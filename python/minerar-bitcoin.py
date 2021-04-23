# blockchain.com/pt/explorer

from hashlib import sha256
import time

def aplicar_sha256(texto):
   return sha256(texto.encode("ascii")).hexdigest()

def minerar(num_bloco, transacoes, hash_anterior, qtd_zeros):
   nonce = 0
   while True:
      texto = str(num_bloco) + transacoes + hash_anterior + str(nonce)
      meu_hash = aplicar_sha256(texto)
      if meu_hash.startswith("0" * qtd_zeros):
         return nonce, meu_hash
      nonce += 1

if __name__ == "__main__":
   num_bloco = 680296
   transacoes = """
   teste
   """
   qtd_zeros = 6
   hash_anterior = "000000000000000000076ff17d9319d3a6b5ef338ca150e2e0127daf6525754a"
   resultado = minerar(num_bloco, transacoes, hash_anterior, qtd_zeros)
   print(resultado)