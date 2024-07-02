![app](https://raw.githubusercontent.com/rizitis/GPT4All.SlackBuild/main/3.0.0.png)

![app](https://raw.githubusercontent.com/rizitis/GPT4All.SlackBuild/main/3.0.0-light.png)

![app](https://raw.githubusercontent.com/rizitis/GPT4All.SlackBuild/main/3.0.0-3.png)
Open-source large language models, run locally on your CPU and nearly any GPU.

1. From suggested by app models, the best model I found for localldocs is Mistal OpenOrca.  
2. Read README.Slackware before build.

HOWTO:

DOCS: https://docs.gpt4all.io/index.html

DISCORD: https://discord.gg/nomic-ai-1076964370942267462

Source: https://github.com/nomic-ai/gpt4all/

TIPS:
1. Personally I also have cloned https://github.com/ggerganov/llama.cpp

`To build it  only for CPU just run
make LLAMA_OPENBLAS=1 
Everything else you might need is in README...`

2. Now you can use llama.cpp/models/ folder as a place for your *.gguf models for gpt4all app.
