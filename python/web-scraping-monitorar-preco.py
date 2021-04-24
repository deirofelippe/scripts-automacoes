from bs4 import BeautifulSoup
import requests
import smtplib
import credenciais
import babel.numbers
import unicodedata

url = "https://www.pichau.com.br/hardware/processadores/amd/processador-amd-ryzen-5-3600-hexa-core-3-6ghz-4-2ghz-turbo-35mb-cache-am4-yd3600bbafbox"

# my user agent
headers = { "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:86.0) Gecko/20100101 Firefox/86.0" }

html_site = requests.get(url, headers = headers)

soup = BeautifulSoup(html_site.content, "html.parser")

nome_produto = soup.find("div", class_ = "product title").h1.get_text()
preco_produto = soup.find("span", class_ = "price").get_text()
preco_produto = preco_produto[2:10]
preco_produto = preco_produto.replace(".","")
preco_produto = preco_produto.replace(",",".")
preco_produto = float(preco_produto)
preco_formatado = babel.numbers.format_currency(preco_produto, "BRL", locale="pt_BR")

def send_email():
   conteudo = f"""
   O preço abaixou do produto: {nome_produto}
   O preço é de {preco_formatado}
   Acesse o site: {url}
   """

   conteudo = unicodedata.normalize('NFKD', conteudo).encode('ascii', 'ignore').decode('utf8')
   conection = smtplib.SMTP_SSL(credenciais.smtp_server, credenciais.smtp_port_ssl)
   conection.login(credenciais.email, credenciais.senha)
   conection.sendmail(credenciais.email, credenciais.email, conteudo)
   conection.quit()
   print("Email enviado")

if(preco_produto < 1800):
   send_email()

