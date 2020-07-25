import os
import csv
import pathlib

path = ""

while True:
    file_name = input("修正するファイル名を入力:  ")
    file_name += ".csv"
    path = os.path.join(os.getcwd(), "csv", file_name)

    if os.path.exists(path):
        break
    else:
        print("入力したファイルが見つかりません。")

while True:
    root_file_name = input("修正した結果を保持するファイル名を入力:  ")
    new_file_name = root_file_name + ".csv"
    new_file_path = os.path.join(os.getcwd(), "csv", new_file_name)

    if os.path.exists(new_file_path):
        print("既に同じ名前のファイルが存在しています。")
    else:
        break

questions = []

with open(path) as f:
    reader = csv.reader(f, quoting=csv.QUOTE_NONE, escapechar="\\")
    questions += [row for row in reader]

count = 0

for q in questions:
    count += 1
    print("\n\n\n")
    print(f"現在 {count} / {len(questions)}")
    if len(q) != 5:
        print(f"長さが不適切: {q}")
        continue
    print(f"問題文: {q[0]}")
    print(f"答え　: {q[1]}")
    print(f"選択肢: {q[2]}")
    print(f"選択肢: {q[3]}")
    print(f"選択肢: {q[4]}")

    while True:
        command = input("ファイルに追加しますか？[y/n] ")

        if command == "y":
            break
        if command == "n":
            continue

    with open(new_file_path, "a") as f:
        writer = csv.writer(f, quoting=csv.QUOTE_NONE, escapechar="\\")
        writer.writerow(q)

print("修正が終了しました。")
