import os
import csv
import pathlib
import re

while True:
    file_name = input("分配するファイル名を入力:  ")
    file_name += ".csv"
    path = os.path.join(os.getcwd(), "csv", file_name)

    if os.path.exists(path):
        break
    else:
        print("入力したファイルが見つかりません。")

size = int(input("分配される問題数を入力:  "))

root_file_name = input("分配されるファイル名を入力:  ")

print("問題を分配しています...")

questions = []

with open(path) as f:
    reader = csv.reader(f, quoting=csv.QUOTE_NONE, escapechar="\\")
    questions = [row for row in reader]

version = 1

while len(questions) >= size:
    new_questions = []
    for i in range(size):
        new_questions.append(questions[0])
        questions.pop(0)

    new_file_name = root_file_name + f"_{version}.csv"
    new_file_path = os.path.join(os.getcwd(), "csv", new_file_name)

    with open(new_file_path, "w") as f:
        writer = csv.writer(f, quoting=csv.QUOTE_NONE, escapechar="\\")
        writer.writerows(new_questions)

    print(f"ファイルを作成しました:  {new_file_path}")
    version += 1

print(f"{len(questions)}この質問が余りました。")

