import os
import re
import webbrowser


def main():
    clipboard = os.popen("xclip -selection clipboard -o")
    clipboard_content = clipboard.read()
    clipboard.close()

    ticket = re.search(r"[A-Z]{2,}-\d+", clipboard_content)
    if ticket:
        webbrowser.open(
            "https://tasks.opencraft.com/browse/" + ticket.group(0)
        )
        return

    url = re.search("(?P<url>https?://[^\s]+)", clipboard_content)
    if url:
        webbrowser.open(url.group("url"))

if __name__ == "__main__":
    main()
