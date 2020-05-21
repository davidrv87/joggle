# JOGGLE Media Tools

*Joggle* is a tool used to perform different operations over video and audio files.

## Functionalities

*Joggle* can perform the following operations:

* Download videos from YouTube.
* Extract audio from YouTube videos.
* Extract audio from local videos.
* Cut audio or video files into smaller chunks.
* Convert audio format. Supported formats are: **mp3**, **aac**, **ac3**, **ogg** and **wav**.
* Concatenate audio files.

## Installation

*Joggle* can be installed via Docker or locally.

### Using Docker

Only [Docker][docker] is **required** to use *Joggle*. Refer to *Usage* section for instruction on how to run it.

### Installing locally

In order to install *Joggle* locally, follow these steps:

1. Clone this [repository][repository] anywhere in your computer.
2. Open a terminal and go to the directory where you cloned the repository.
3. Run `sudo ./install.sh` on Linux or `./install.sh` on Mac OS X (it may ask for `sudo` password).
4. You're all set!

## Supported Operating Systems

For Docker, all operating systems are supported.

For local installation:
* MacOS X (tested on Catalina 10.15.x). **Requires `brew` to be installed**
* Linux operating systems are supported, such as *Ubuntu 12.04+*.

## Usage

### Via Docker

* Open a terminal.
* Run `docker container run -it -v <local_directory>:/home/joggle davidrv87/joggle`
* Follow the instructions.

For `<local_directory>` you can use any local directory or the current working directory by using:
* Mac/Linux: `$(pwd)`
* PowerShell: `${pwd}`
* Command Prompt: `%cd%`

### Local installation

* Open a terminal.
* Run `joggle`
* Follow the instructions.

## Technology

Joggle uses two main tools in order to perform all the operations with the files.

* [YouTube Downloader][youtube-dl]
* [FFMPEG][ffmpeg]

## Contributing

1. Fork the repository.
2. Create your feature branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

## License

Code copyright 2016. Code released under [the MIT License][license].

[docker]: https://www.docker.com
[repository]: https://github.com/davidrv87/joggle
[youtube-dl]: http://youtube-dl.org/
[ffmpeg]: https://ffmpeg.org/
[license]: https://github.com/davidrv87/joggle/blob/master/LICENSE.txt