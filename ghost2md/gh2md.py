import os
import requests
from html2text import HTML2Text
from bs4 import BeautifulSoup
from urllib.parse import urlparse

# Configs
GHOST_API_URL = "https://blog.robertabrandao.com.br"  # Ex: https://piranguinho.com
CONTENT_API_KEY = "asdfasdfasdfasdfasdfasdfasdfsadf"      # Gere no painel do Ghost
OUTPUT_DIR = "content/posts"

html2md = HTML2Text()
html2md.ignore_links = False
html2md.ignore_images = False
html2md.body_width = 0

def fetch_posts():
    """Comunicacao com a API do Ghost"""
    url = f"{GHOST_API_URL}/ghost/api/content/posts/"
    params = {
        "key": CONTENT_API_KEY,
        "limit": "all",
        "include": "tags,authors"
    }
    response = requests.get(url, params=params)
    response.raise_for_status()
    return response.json()["posts"]

def download_image(url, post_dir, rename=None):
    """Baixa uma imagem e retorna o nome do arquivo local"""
    filename = rename if rename else os.path.basename(urlparse(url).path)
    filepath = os.path.join(post_dir, filename)

    try:
        r = requests.get(url, stream=True, timeout=15)
        r.raise_for_status()
        with open(filepath, "wb") as f:
            for chunk in r.iter_content(1024):
                f.write(chunk)
        return filename
    except Exception as e:
        print(f"Falha ao baixar imagem {url}: {e}")
        return url  # mantém URL original se falhar

def save_post_as_hugo(post):
    slug = post["slug"]
    title = post["title"]
    html_content = post["html"]

    # Diretório do post (Hugo bundle)
    post_dir = os.path.join(OUTPUT_DIR, slug)
    os.makedirs(post_dir, exist_ok=True)

    # Baixar feature_image (se existir)
    featured_image_local = ""
    if post.get("feature_image"):
        featured_image_local = download_image(post["feature_image"], post_dir, rename="featured.jpg" + os.path.splitext(urlparse(post["feature_image"]).path)[1])

    # Parse HTML para capturar imagens do conteúdo
    soup = BeautifulSoup(html_content, "html.parser")
    for img in soup.find_all("img"):
        img_url = img.get("src")
        if img_url:
            local_filename = download_image(img_url, post_dir)
            img["src"] = local_filename  # substitui no HTML

    # Converte HTML atualizado para Markdown
    md_content = html2md.handle(str(soup))

    # Frontmatter YAML
    frontmatter = [
        "---",
        f"title: \"{title}\"",
        f"date: {post['published_at']}",
        f"tags: [{', '.join([t['name'] for t in post['tags']]) if post['tags'] else ''}]",
        f"author: {', '.join([a['name'] for a in post['authors']]) if post['authors'] else ''}",
    ]

    if featured_image_local:
        frontmatter.append(f"featured_image: \"{featured_image_local}\"")

    frontmatter.append("---\n")

    # Salva como index.md
    filepath = os.path.join(post_dir, "index.md")
    with open(filepath, "w", encoding="utf-8") as f:
        f.write("\n".join(frontmatter))
        f.write(md_content)

    print(f"Post salvo: {filepath}")

def main():
    posts = fetch_posts()
    for post in posts:
        save_post_as_hugo(post)

if __name__ == "__main__":
    main()
