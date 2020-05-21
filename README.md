
# Angry Aliens

![optimized](https://user-images.githubusercontent.com/6860637/79353473-60ad7580-7f3b-11ea-8bc7-411bab23032e.gif)

**Angry Aliens** is an open source game made with Godot Engine 3.2.1.

Source code is MIT licensed. Feel free to read it, modify it and reuse it in your projects.

Gameplay is definitely inspired by *Angry Birds*.

### Disclaimer

> This project is used as a base for video tutorials in Italian. All the source code and documentation is in English.
> If you are interested, videos are released [on my Crystal Bit YouTube channel](https://www.youtube.com/playlist?list=PLaCq3HqKQR6rNyqulBsbca-6wzxp8H52r).

## Table of Contents

- [Angry Aliens](#angry-aliens)
    - [Disclaimer](#disclaimer)
  - [Table of Contents](#table-of-contents)
  - [Branches: `master`, `develop` and `video`](#branches-master-develop-and-video)
  - [Prerequisites](#prerequisites)
  - [Tutorial Contents](#tutorial-contents)
    - [1. Introduction](#1-introduction)
    - [2. Configure Godot and Android SDK](#2-configure-godot-and-android-sdk)
    - [3. Testing performances on the smartphone](#3-testing-performances-on-the-smartphone)
    - [4. Slingshot](#4-slingshot)
    - [5. Enemies](#5-enemies)
    - [6. Level](#6-level)
    - [7. Obstacles](#7-obstacles)
    - [8. Level finished screen](#8-level-finished-screen)
    - [9. Camera](#9-camera)
    - [[EXTRA] Possible improvements / future topics](#extra-possible-improvements--future-topics)
  - [Credits](#credits)
  - [Thanks](#thanks)
  - [Support me](#support-me)

## Branches: `master`, `develop` and `video`
- `develop` branch contains the complete project.Some advanced features may not be included in the master branch.
- `master` branch will be in sync with video tutorials releases on my YouTube channel.
- `videoX/start` branches contains the code to follow the tutorial number `X`. Example:
  - `video5/start` contains the code to follow the [video tutorial 5](https://youtu.be/SVuOYKzTwxw) on YouTube.

## Prerequisites

The tutorials require basic Godot understanding about Scenes, GDScript, 2D Nodes such as Sprite2D, CollisionShape2D, Area2D.

You can learn these topics by:

- reading the [official documentation](https://docs.godotengine.org/en/3.1/getting_started/step_by_step/intro_to_the_editor_interface.html)
- following my [video tutorial series](https://www.youtube.com/watch?v=AY1zuH2mHQ0&list=PLaCq3HqKQR6rlPpf2GAOXp52ddt0V71Yl) on Godot 3 basics (*only in Italian*)

## Tutorial Contents

### 1. Introduction

- 🎥 [YouTube - #1 - Introduzione](https://youtu.be/x0emyyXC_sM)

This tutorial series will focus on creating a simple mobile game
using Godot 3.2.

I choose to make an Angry Birds clone because:

1. it is short to recreate (without adding polish) 
2. it allows to stress Godot performances on the worst case scenario: intense game (physics based) on a low-power device (smartphone)

I'm creating these tutorials using Manjaro Linux (Arch Linux derivative), but similar steps can be done on other operating systems as well.

Currently I don't have an Apple device and I cannot develop/test iOS/OSX games. I'll try to provide instructions for other OSs, but help here is really appreciated (especially if you are a Debian, Ubuntu, Windows or OSX user).

### 2. Configure Godot and Android SDK

- 🎥 [YouTube - #2 - Configurare Linux](https://youtu.be/xFia7zG8NGA)
- 🎥 [YouTube - #3 - Configurare Windows](https://youtu.be/PNj8YmXjj-A)
  
> How do I configure my computer for Android development?

- `android-tools` and `jdk-openjdk`
- debug keystore
- Godot configuration
- Export templates
- **APK creation**
- APK one click installation

### 3. Testing performances on the smartphone

- 🎥 [YouTube - #4 - Creare il livello](https://youtu.be/VZS0pv14--s)
- 🎥 [YouTube - #5 - Creare la scena StressTest (pt1)](https://youtu.be/SVuOYKzTwxw)
- 🎥 [YouTube - #6 - Stress test (pt.2) - Debugger e profiler](https://youtu.be/s4jSWPtqR8M)
- 🎥 [YouTube - #7 - Stress test (pt.3) - Debugging su Android con Remote Debugger](https://youtu.be/-z6w9ArPFBY)

> If we include all the physics elements and we create hundreds of game objects, is the game playable?

![Stress test scene screen](Assets/readme/stress-test.png)

### 4. Slingshot

- 🎥 [YouTube - #8 - Lancio Proiettili (Pt.1) - Godot 3.2 Tutorial](https://youtu.be/W16SLhgp8Zk)
- 🎥 [YouTube - #9 - TouchScreen Input: Press, Release e Drag - Lancio Proiettili (Pt.2) - Godot 3.2 Tutorial](https://youtu.be/vVDVJMomxBU)

- Create a projectile
- Create a simple slingshot
- Input handling for mouse and touchscreen
- Projectile launch
- Load new projectile
- [Draw trajectory]
- [Draw max distance?]

### 5. Enemies

- Rigid bodies with collision detection
- Enemies destruction
- enemy destroyed signal
- simple score preview

### 6. Level

![Image level screen](Assets/readme/level.png)

- Mobile Layout
- Multiple resolutions handling
- GUI elements positioning

### 7. Obstacles

- Obstacle scene
- Debris texture
- Obstacle destruction

### 8. Level finished screen

- Level completed detection
- Touch buttons
- GUI with score

### 9. Camera 

- Camera pan
- Camera focus handling
- Fix input

### [EXTRA] Possible improvements / future topics

This tutorial covers only a small subset of mobile game development topics.

There are a lot of areas that can be explored, like:

- Publishing on a game store
  - Fdroid
  - Play Store
- Add audio sfx
- Improve the slingshot
  - elastic animation
- Parallax background
- Moving clouds
- Add particle effects
  - debris on obstacles destruction
  - dust effects on collisions
  - improve performances with object pooling
- Android modules
- Double tap, drag 'n drop, pinch to zoom,...
- Using Sensors (GPS, accelerometer, light sensor, bluetooth,...)

Some of these topics may be covered on [my YouTube channel](https://www.youtube.com/c/CrystalBit)
as separated videos.

Keep an eye on the [Crystal Bit Github organization](https://github.com/crystal-bit) as well, because
all the source code for my tutorials will be uploaded here.

## Credits

- **Kenney** for most of the game assets - https://www.kenney.nl/
- **Hanabi** for the slingshot sprites

## Thanks

- My community for the support on YouTube, Telegram and in person 🙋
- Gameloop.it community for the Harvard [CS50 gamedev course](https://github.com/GameLoop-it/cs50_course_materials)
- [YouAreUto](http://youareuto.com/) game & team - My first mobile game as a freelance game developer
- Godot Engine community for the excellent documentation and software 
- [Godot Engine Italia](https://godotengineitalia.com/) 🍕

## Support me

I love creating free game projects and tutorials. If you want to help me, 
I really appreciate! You can:

- Star this repository
- Retweet the project
- Talk to your friends about this project
- Test the game and report issues
- Open PRs

Right now I don't have any donation page setup. If you are considering this, 
feel free to reach me out on vitrumbit@gmail.com
