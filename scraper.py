import os
import csv
import pathlib
import re
import random
import requests
from bs4 import BeautifulSoup

first_text = "***START OF THE PROJECT GUTENBERG EBOOK A MIRROR OF THE TURF***"
end_text = "***END OF THE PROJECT GUTENBERG EBOOK A MIRROR OF THE TURF***"

special_words = ["Mr", "Mrs", "St", "gs"]
special_symbols = "[!\"#$%&'\\\\()*+,-./:;<=>?@[\\]^_`{|}~「」〔〕“”〈〉『』【】＆＊・（）＄＃＠。、？！｀＋￥％]"

# 特殊記号を抜く
code_regex = re.compile(special_symbols)

# http://gutenberg.org/files/62606/62606-h/62606-h.htm

# 問題文を作る
def create_questions(raw_data):
    word_data = set()
    sentences = []
    questions = []

    for p in raw_data:
        # 改行をなくす
        new_p = re.sub(r"(?<!\n)\n(?![\n\t])", " ", str(p).replace("\r", ""))

        # 最初と最後の["]の削除
        if len(new_p) > 1:
            if new_p[0] == '"':
                new_p = new_p[1:]
            if new_p[-1] == '"':
                new_p = new_p[:-1]

        # 一文辺り取り出す
        sentence = ""
        quote_count = 0
        for c in new_p:

            # 謎のダブルクオテーション対策
            if c == "“" or c == "”":
                c = '"'

            sentence += c

            if c == '"':
                quote_count += 1

            # 文の終わりの場合
            if c == ".":
                flag = True
                # Mr, Mrsなどの単語のチェック
                for sw in special_words:
                    if sw in sentence[-4:]:
                        flag = False
                # 最後の文字が大文字、数字であるかのチェック
                if len(sentence) > 2:
                    if len(re.findall("[A-Z0-9\u2160-\u217F_]", sentence[-2])) > 0:
                        flag = False
                # いずれでもなければ文章の終わりと判定
                if flag:
                    if quote_count % 2 == 1:
                        sentence += '"'
                    sentences.append(sentence)
                    sentence = ""
                    quote_count = 0

    for s in sentences:
        words = []
        word = ""

        # 最初の空白を削除
        s = s.lstrip()

        # 最初の文字が大文字でなければ削除
        if len(s) > 0:
            if len(re.findall("[A-Z]", s[0])) != 1:
                continue

        # 単語を取り出す
        for c in s:
            if len(re.findall(special_symbols, c)) > 0:
                continue
            if c == " ":
                words.append(word)
                word = ""
            elif c == ".":
                if word in special_words:
                    word += c
                elif len(word) > 0:
                    if len(re.findall("[A-Z0-9\u2160-\u217F_]", word[-1])) > 0:
                        word += c
                    else:
                        words.append(word)
                        word = ""
                else:
                    words.append(word)
                    word = ""
            else:
                word += c

        # 短すぎる問題と長すぎる問題は削除
        if len(words) <= 3 or 45 < len(words):
            continue

        # 答えを決める
        answer_count = 0
        while True:
            answer_index = random.randint(0, len(words) - 1)
            answer = words[answer_index]

            answer_count += 1
            if len(re.findall(special_symbols, answer)) == 0:
                break
            if answer_count > 50:
                print("的する答えが見つかりませんでした。")
                break
        if answer_count > 50:
            continue

        # 単語から特殊記号を抜き取る
        for w in words:
            w = code_regex.sub("", w)
        answer = code_regex.sub("", answer)

        # 文章のカンマを変えて、答えを抜き出す
        new_sentence = s.replace(",", "_").replace(" " + answer + " ", " * ", 1)

        # 改行をなくす
        new_p = re.sub(r"(?<!\n)\n(?![\n\t])", " ", new_sentence.replace("\r", ""))

        questions.append([new_sentence, answer])
        word_data |= set(words)

    data_size = len(word_data)
    data_list = list(word_data)

    # 選択肢追加
    for q in questions:
        choices = []
        for i in range(3):
            while True:
                choice = data_list[random.randint(0, data_size - 1)]
                # 被りがないかをチェック
                flag = True
                for j in range(1, i + 1):
                    if questions[j] == choice:
                        flag = False
                if flag:
                    choices.append(choice)
                    break
        q += choices
    return questions


url = input("URLを入力:  ")
while True:
    file_name = input("ファイル名を入力:  ")
    file_name += ".csv"
    path = os.path.join(os.getcwd(), "csv", file_name)

    if os.path.exists(path) == False:
        break
    else:
        print("入力したファイル名はすでに存在しています。他のファイル名を入力してください。")

# レスポンス取得
print("URLのサイトにアクセスしています...")
response = requests.get(url)

if response.status_code != 200:
    print(
        f"""レスポンスを正常に取得できませんでした。
処理を終了します。
url: {url}
status code: {response.status_code}"""
    )
    exit()

print("正常にレスポンスを取得しました。")

# ファイル作成
csv_file = pathlib.Path(path)
csv_file.touch()
print("ファイルが作成されました。")

# BeautifulSoupの設定
print("データをフォーマットしています。")
soup = BeautifulSoup(response.content, "html.parser")
[x.extract() for x in soup.findAll("span")]
[x.extract() for x in soup.findAll("i")]
[x.extract() for x in soup.findAll("a")]

raw_data = soup.find_all("p", class_="")

# HTMLタグを削除する
raw_data = [x.text for x in raw_data]

print("問題を作成しています")
questions = create_questions(raw_data)

with open(path, "w") as f:
    writer = csv.writer(f, quoting=csv.QUOTE_NONE, escapechar="\\")
    writer.writerows(questions)

print(
    f"""問題を作成しました。
作成したファイルの場所:  {path}
問題数:  {len(questions)}"""
)

for q in questions:
    if len(q) != 5:
        print(f"エラーの文章: {q}")
