from generation.generator import generate_podcast_series

def main():
    generate_podcast_series(
        series_topic="请帮我生成一期适合 Podcast 的日语单词讲解内容，从 JLPT N5 到 N1 每级各选 3 个常见单词，共 15 个。每个单词需包含平假名、汉字（如有）、中文意思、一个日语例句（附中文翻译），并在例句中将日语朗读三遍，适合听众跟读。整体语气亲切自然，适合中文为主、日语配合的讲解方式，讲解时可加入类似“听众朋友们，一起来念一念吧”这类引导语，每个词讲解不超过一分钟。",
        language="zh",
        number_of_episodes=1000,
        word_count=6000
    )

if __name__ == "__main__": 
    main()