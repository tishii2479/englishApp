import os
import csv
import pathlib
import re
import random
import requests
from bs4 import BeautifulSoup

first_text = "***START OF THE PROJECT GUTENBERG EBOOK A MIRROR OF THE TURF***"
end_text = "***END OF THE PROJECT GUTENBERG EBOOK A MIRROR OF THE TURF***"

special_words = ["Mr", "Mrs", "St"]

# 問題文を作る
def create_questions(raw_data):
    word_data = set()
    sentences = []
    questions = []

    for p in raw_data:
        # 改行をなくす
        new_p = re.sub(r"(?<!\n)\n(?![\n\t])", " ", str(p).replace("\r", ""))

        # 一文辺り取り出す
        sentence = ""
        for c in new_p:
            sentence += c

            # 文の終わりの場合
            # Mr.等に対応する必要がある
            if c == ".":
                flag = True
                # Mr, Mrsなどの単語のチェック
                for sw in special_words:
                    if sw in sentence[-4:]:
                        flag = False
                # 最後の文字が大文字、数字であるかのチェック
                if len(re.findall("[A-Z0-9\u2160-\u217F_]", sentence[-2])) > 0:
                    flag = False
                # いずれでもなければ文章の終わりと判定
                if flag:
                    sentences.append(sentence)
                    sentence = ""

    for s in sentences:
        words = []
        word = ""
        new_sentence = ""

        # 最初の空白を削除
        s = s.lstrip()

        # 単語を取り出す
        for c in s:
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

        if len(words) <= 0:
            continue

        # 答えを決める
        answer_index = random.randint(0, len(words) - 1)
        answer = words[answer_index]

        for i in range(len(words)):
            # 答えになった箇所を埋める場合
            if i == answer_index:
                new_sentence += "*" + " "
            # 最後の単語の場合
            elif i == len(words) - 1:
                new_sentence += words[i] + "."
            else:
                new_sentence += words[i] + " "

        questions.append([new_sentence, answer])
        word_data |= set(words)

    data_size = len(word_data)
    data_list = list(word_data)

    # 選択肢追加
    for q in questions:
        choices = []
        for i in range(3):
            choices.append(data_list[random.randint(0, data_size - 1)])
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
    writer = csv.writer(f)
    writer.writerows(questions)

print(
    f"""問題を作成しました。
作成したファイルの場所:  {path}
"""
)
