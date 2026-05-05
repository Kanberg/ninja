#!/bin/bash

# 0:00–0:05 — чёрный экран + текст
ffmpeg -f lavfi -i color=c=black:s=1920x1080:d=5 \
-vf "drawtext=text='Когда ночь стирает границы…':fontcolor=white:fontsize=48:x=(w-text_w)/2:y=h-200:alpha='if(lt(t,1),0,if(lt(t,3),(t-1)/2,1))'" \
-c:v libx264 -pix_fmt yuv420p scene0.mp4

# 0:06–0:12 — image-1
ffmpeg -loop 1 -i image-1.jpg -t 6 \
-vf "scale=1920:1080,zoompan=z='1+0.02*t':d=1" \
-c:v libx264 -pix_fmt yuv420p scene1.mp4

# 0:13–0:20 — перебивки
ffmpeg -loop 1 -i image-2.jpg -t 2 -vf "scale=1920:1080,zoompan=z='1+0.03*t':d=1" -c:v libx264 scene2a.mp4
ffmpeg -loop 1 -i image-3.jpg -t 2 -vf "scale=1920:1080,zoompan=z='1+0.04*t':d=1" -c:v libx264 scene2b.mp4
ffmpeg -loop 1 -i image-4.jpg -t 3 -vf "scale=1920:1080,zoompan=z='1+0.02*t':d=1" -c:v libx264 scene2c.mp4

# 0:21–0:30 — image-5
ffmpeg -loop 1 -i image-5.jpg -t 10 \
-vf "scale=1920:1080,zoompan=z='1+0.015*t':d=1" \
-c:v libx264 scene3.mp4

# 0:31–0:40 — image-3
ffmpeg -loop 1 -i image-3.jpg -t 10 \
-vf "scale=1920:1080,zoompan=z='1+0.025*t':d=1" \
-c:v libx264 scene4.mp4

# 0:41–0:50 — image-6
ffmpeg -loop 1 -i image-6.jpg -t 10 \
-vf "scale=1920:1080,zoompan=z='1+0.01*t':d=1" \
-c:v libx264 scene5.mp4

# 0:51–0:57 — image-1
ffmpeg -loop 1 -i image-1.jpg -t 7 \
-vf "scale=1920:1080,zoompan=z='1+0.02*sin(t*2)':d=1" \
-c:v libx264 scene6.mp4

# 0:58–1:00 — титр
ffmpeg -f lavfi -i color=c=black:s=1920x1080:d=2 \
-vf "drawtext=text='THE END':fontcolor=white:fontsize=64:x=(w-text_w)/2:y=(h-text_h)/2" \
-c:v libx264 scene7.mp4

# Сборка всех сцен
ffmpeg -f concat -safe 0 -i <(printf "file '%s'\n" scene0.mp4 scene1.mp4 scene2a.mp4 scene2b.mp4 scene2c.mp4 scene3.mp4 scene4.mp4 scene5.mp4 scene6.mp4 scene7.mp4) \
-c copy final_video.mp4
