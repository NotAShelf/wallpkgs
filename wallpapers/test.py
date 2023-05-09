import os

class Readme:
    tags = {}
    folders = ["./test/"]
    readme = "./README.md"

    def learn_tags(self):
        for folder in self.folders:
            for img in os.listdir(folder):
                tags = "".join(img.split(".")[:-1]).split("_")
                for tag in tags[1:]:
                    if not isinstance(self.tags.get(tag),list):
                        self.tags[tag] = []
                    self.tags[tag].append([folder+img,tags[0]])
    
    def make_readme(self):
        out = ""
        for tag,imgs in self.tags.items():
            out += f"\n<hr>\n<details><summary>{tag}</summary>\n"
            for path,name in imgs:
                out += f'<img src="{path}" title="{name}"><br>\n'
            out += f"</details>"
        with open(self.readme,"w") as f:
            f.write(out)
    
r = Readme()
r.learn_tags()
print(r.tags)
r.make_readme()
