from generation.generator import generate_podcast_series

def main():
    generate_podcast_series(
        series_topic="请帮我生成一期适合 Podcast 的日语单词讲解内容，讲解 JLPT N5 到 N1 每级单词。每个单词需包含平假名、汉字（如有）、中文意思、一个日语例句（附中文翻译），并在例句中将日语朗读三遍，适合听众跟读。整体语气亲切自然，适合中文为主、日语配合的讲解方式。",
        language="zh",
        number_of_episodes=35,
        word_count=3800
    )

if __name__ == "__main__": 
    main()