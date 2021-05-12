import ffmpeg
from pytube import YouTube
from os import system
import os
import re
import sys

# pip install ffmpeg-python pytube
# sudo apt install ffmpeg

def pedir_url():
   system('clear')
   while True:
      print(f"Quantidade de urls: {len(urls)}")
      url = input("\nDigite a url (f - finalizar): ")
      if(url == "f"):
         break
      urls.append(url)
      system('clear')
      print(urls)

def iniciando_variaveis():
   global streams
   global output_path
   global filename_audio
   global filename_video
   global filename_final

   yt = YouTube(url)
   titulo = re.sub(r"[+=;<>/\\:|()!@',#$%*{}°\"]*[^\w -_.]*", '', yt.title)
   print("Titulo: "+yt.title)
   streams = yt.streams

   output_path = "/home/boibandido/Downloads/teste/"
   extensao = ".webm"
   filename_audio = titulo + "_audio"
   filename_video = titulo + "_video"
   filename_final = output_path + titulo + extensao

def exibir_formatos():
   global streams_audios
   global streams_videos

   streams_audios = streams.filter(file_extension="webm", only_audio=True).order_by('abr').asc()

   streams_videos = streams.filter(file_extension="webm", only_video=True).order_by('resolution').desc()

   print('\nTodos os formatos de audio:')
   print(streams_audios)
   print('\nTodos os formatos de video:')
   print(streams_videos)

   streams_audios = streams_audios.order_by('abr').desc().first()

   if(streams_videos.first().resolution == '1080p'):
      streams_videos = streams_videos[1]
   else:
      streams_videos = streams_videos[0]

   print('\nFormato selecionado de audios:')
   print(streams_audios)
   print('\nFormato selecionado de videos:')
   print(streams_videos)

def fazer_download():
   global output_video_download
   global output_audio_download
   
   print("\nFazendo download do audio...")
   output_audio_download = streams_audios.download(output_path=output_path, filename=filename_audio)
   print("Download feito!")

   print("\nFazendo download do video...")
   output_video_download = streams_videos.download(output_path=output_path, filename=filename_video)
   print("Download feito!")

def juntar_audio_video():
   audio_ffmpeg = ffmpeg.input(output_audio_download)
   video_ffmpeg = ffmpeg.input(output_video_download)

   print("\nJuntando audio e video...")
   ffmpeg.output(audio_ffmpeg, video_ffmpeg, filename_final, acodec='copy', vcodec='copy').run()
   print("Juncao finalizada!")

def deletar_arquivos():
   print("\nDeletando arquivos...")
   os.remove(output_audio_download)
   os.remove(output_video_download)
   print("Arquivos deletados!")

while True:
   urls = []

   pedir_url()
   
   for url in urls:
      print(f"\nURL buscada '{url}'")
      
      try:
         iniciando_variaveis()
         exibir_formatos()
         fazer_download()
         juntar_audio_video()
         deletar_arquivos()
      except Exception as e:
         print(f"\nErro na url '{url}'")
         print(e.with_traceback(tb=None))
         continue

   finalizar = input("\nDeseja finalizar (s/n)? ")

   if(finalizar == 's'):
      system('clear')
      break