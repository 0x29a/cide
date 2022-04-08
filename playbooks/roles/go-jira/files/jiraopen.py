import os
import re
import webbrowser


def main():
    clipboard = os.popen("xclip -selection clipboard -o")
    ticket = re.search(r"[A-Z]{2,}-\d+", clipboard.read())
    webbrowser.open(
        "https://tasks.opencraft.com/browse/" + ticket.group(0)
    ) if ticket else None
    clipboard.close()


if __name__ == "__main__":
    main()
