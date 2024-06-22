import argparse

# create parser to be configured with the expected arguments
parser = argparse.ArgumentParser(
    description="example script on how to use argparse")

parser.add_argument(
    '-i', '--idea_md',
    required=True,
    help="md idea")

parser.add_argument(
    '-s', '--storage',
    required=True,
    help="storage folder")

# once arguments are created it is time to parse it
args = parser.parse_args()

class SourceFile:
    class Collector:
        def __init__(self, id):
            self.id = id
            self.source = ""

        def add_line(self, line):
            self.source += line

        def finish(self):
            return (id, self.source)

    def __init__(self, file_path):
        file = open(file_path, "r")
        self.lines = file.readlines()
        file.close()
        self.chunks = {}

    def get(self, id):
        return self.chunks[id]

    def get_chunk_id(self, line):
        return line.split(":")[1].strip()

    def parse(self):
        collectors = []
        for line in self.lines:
            if "sandbox_link_start:" in line:
                collectors.append(self.Collector(self.get_chunk_id(line)))
                continue
            if "sandbox_link_end:" in line:
                for c in collectors:
                    if c.id == self.get_chunk_id(line):
                        self.chunks[self.get_chunk_id(line)] = c.finish()[1]
                continue
            for c in collectors:
                c.add_line(line)

class FileReader:
    def __init__(self, file_path, storage_path):
        self.file_path = file_path
        self.storage_path = storage_path
        file = open(file_path, "r")
        self.lines = file.readlines()
        file.close()
        self.links = []

    def parse_link(self, lines, index):
        arguments = lines[index].split("sandbox_idea_link:")[
            1].replace(")", "")
        arguments = ' '.join(arguments.split()).split(" ")
        ret = dict()
        for arg in arguments:
            k, v = arg.split(":")
            ret[k.strip()] = v.strip()

        ret["ext"] = ret["file"].split(".")[1]
        ret["linked"] = (f"```{ret['ext']}" in lines[index+1])
        return ret

    def parse(self):
        self.links = []
        for i, line in enumerate(self.lines):
            if "sandbox_idea_link" in line:
                link = self.parse_link(self.lines, i)
                link["line"] = i
                self.links.append(link)

    def get_source_files(self):
        source_files = []
        for l in self.links:
            source_files.append(l["file"])
        return set(source_files)

    def reset(self):
        lines = []
        flag = True
        for i,l in enumerate(self.lines):
            if "```" in l and "sandbox_idea_link" in self.lines[i-1]:
                flag = False
            if flag:
                lines.append(l)
            if not flag and "```\n" in l:
                flag = True
 
        f = open(self.file_path, "w")
        self.lines = lines
        f.write("".join(self.lines))

    def link(self):
        sources = {}
        for f in self.get_source_files():
            sources[f] = SourceFile(self.storage_path + f)
            sources[f].parse()
        
        ret = ""
        for i, l in enumerate(self.links):
            ret += "".join(self.lines[0 if i ==
                           0 else self.links[i-1]["line"]+1:int(l["line"])+1])
            ret += f"```{l['ext']}\n"
            ret += sources[l["file"]].get(l["id"])
            ret += "```\n"
        s = 0 if len(self.links) == 0 else self.links[-1]["line"] + 1
        ret += "".join(self.lines[s:])
        f = open(self.file_path, "w")
        f.write(ret)


if __name__ == "__main__":
    reader = FileReader(args.idea_md, args.storage)
    reader.parse()
    reader.reset()
    reader.parse()
    reader.link()
