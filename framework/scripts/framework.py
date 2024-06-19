# TODO  share functionality

import os
import argparse

ROOT_DIR = "/".join(__file__.split("/")[:-1]) + "/../../"

parser = argparse.ArgumentParser()

parser.add_argument(
    '--lang',
    default='cpp',
    help="target lang")

parser.add_argument(
    '--reset',
    action='store_true',
    help="reset main")

parser.add_argument(
    '--save',
    action='store_true',
    help="save idea")

parser.add_argument(
    '--load',
    type=str,
    help="load idea")

parser.add_argument(
    '--storage',
    type=str,
    default=f"{ROOT_DIR}/ideas/",
    help="ideas storage path")

args = parser.parse_args()


def reset_idea(lang):
    os.system(f"rm {ROOT_DIR}/main.*")
    os.system(
        f"cp {ROOT_DIR}/framework/templates/{lang}_main.template {ROOT_DIR}/main.{lang}")


def get_main_file():
    matches = [f for f in os.listdir(ROOT_DIR) if os.path.isfile(
        os.path.join(ROOT_DIR, f)) and "main" in f]
    return matches[0] if len(matches) > 0 else None


def get_meta():
    main = get_main_file()
    if main is not None:
        with open(f"{ROOT_DIR}/{main}", "r") as f:
            return (main, f.readline().split("idea:")[1].strip() + "." + main.split(".")[1])
    return None


def save_idea(meta, storage):
    os.system(f"mkdir -p {storage}/{meta[1].split('.')[0]}")
    os.system(f"cp {meta[0]} {storage}/{meta[1].split('.')[0]}/{meta[1]}")


def load_idea(idea, lang, storage):
    os.system(f"rm {ROOT_DIR}/main.*")
    os.system(f"cp {storage}/{idea}/{idea}.{lang} main.{lang}")


if __name__ == "__main__":
    if args.reset:
        reset_idea(args.lang)
    if args.save:
        save_idea(get_meta(), args.storage)
    if args.load:
        load_idea(args.load, args.lang, args.storage)
