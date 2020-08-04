import os
import csv
import pathlib
import random

paths = []

while True:
    while True:
        file_name = input("分配するファイル名を入力:  ")
        file_name += ".csv"
        path = os.path.join(os.getcwd(), "csv", file_name)

        if os.path.exists(path):
            paths.append(path)
            break
        else:
            print("入力したファイルが見つかりません。")

    command = input("ファイルを追加しますか？[y/n]")
    if command == "n":
        break

size = int(input("分配される問題数を入力:  "))

root_file_name = input("分配されるファイル名を入力:  ")

print("問題を分配しています...")

questions = []

for path in paths:
    with open(path) as f:
        reader = csv.reader(f, quoting=csv.QUOTE_NONE, escapechar="\\")
        questions += [row for row in reader]

version = 1

while len(questions) >= size:
    new_questions = []
    for i in range(size):
        index = random.randint(0, len(questions) - 1)
        new_questions.append(questions[index])
        questions.pop(index)

    new_file_name = root_file_name + f"_{version}.csv"
    new_file_path = os.path.join(os.getcwd(), "csv/book", new_file_name)

    with open(new_file_path, "w") as f:
        writer = csv.writer(f, quoting=csv.QUOTE_NONE, escapechar="\\")
        writer.writerows(new_questions)

    print(f"ファイルを作成しました:  {new_file_path}")
    version += 1

print(f"{len(questions)}個の質問が余りました。")

