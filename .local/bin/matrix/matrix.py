import curses
import random

# --- CONFIGURATION ---
MIN_TAIL = 10
MAX_TAIL = 30
LYRIC = "NEVER GONNA GIVE YOU UP NEVER GONNA LET YOU DOWN "
# ---------------------

def draw_matrix(stdscr):
    curses.curs_set(0)
    stdscr.nodelay(True)
    # Enable keypad to capture Arrow Keys
    stdscr.keypad(True) 
    curses.start_color()
    curses.use_default_colors()

    # Initial State
    fps = 20 # Starting FPS
    trans = True
    paused = False
    
    def apply_theme(is_trans):
        bg = -1 if is_trans else curses.COLOR_BLACK
        curses.init_pair(1, curses.COLOR_GREEN, bg)
        curses.init_pair(2, curses.COLOR_WHITE, bg)
        stdscr.bkgd(' ', curses.color_pair(1)) 
        stdscr.clear()

    apply_theme(trans)

    height, width = stdscr.getmaxyx()
    drops = [random.randint(-height, 0) for _ in range(width)]
    trail_lengths = [random.randint(MIN_TAIL, MAX_TAIL) for _ in range(width)]
    active_rick = [0] * width 
    chars = "abcdefghijklmnopqrstuvwxyz0123456789$+-*/=%#&_?!"

    try:
        while True:
            # timeout is in milliseconds: 1000ms / FPS
            stdscr.timeout(int(1000 / fps))
            key = stdscr.getch()
            
            if key != -1:
                # Handle Toggle Pause
                if key == 27 or (key < 256 and chr(key).lower() == 'p'):
                    paused = not paused
                    if paused:
                        msg = " [ PAUSED ] Arrows: FPS | (T)ransparency | (Q)uit "
                        stdscr.addstr(height//2, (width-len(msg))//2, msg, curses.A_REVERSE)
                    else:
                        # Change text to RESUMED before the rain hits it
                        msg = " [ RESUMED ] "
                        stdscr.addstr(height//2, (width-len(msg))//2, msg, curses.A_REVERSE)
                    stdscr.refresh()
                
                elif key < 256 and chr(key).lower() == 'q':
                    break
                
                # FPS Control (Up/Down Arrows)
                if key == curses.KEY_UP:
                    fps = min(fps + 5, 120) # Max 120 FPS
                elif key == curses.KEY_DOWN:
                    fps = max(fps - 5, 5)   # Min 5 FPS

                if paused:
                    if key < 256 and chr(key).lower() == 't':
                        trans = not trans
                        apply_theme(trans)
                        msg = " [ PAUSED ] Arrows: FPS | (T)ransparency | (Q)uit "
                        stdscr.addstr(height//2, (width-len(msg))//2, msg, curses.A_REVERSE)
                    stdscr.refresh()
                    continue 

            if paused:
                continue

            # --- ANIMATION ---
            for i in range(width):
                y = drops[i]
                char = LYRIC[active_rick[i] % len(LYRIC)] if active_rick[i] > 0 else random.choice(chars)
                if active_rick[i] > 0: active_rick[i] += 1

                if 0 <= y < height - 1:
                    stdscr.addch(y, i, char, curses.color_pair(2))
                if 0 <= y - 1 < height - 1:
                    stdscr.addch(y - 1, i, char, curses.color_pair(1))
                
                tail_end = y - trail_lengths[i]
                if 0 <= tail_end < height - 1:
                    stdscr.addch(tail_end, i, ' ')

                drops[i] += 1
                if y - trail_lengths[i] >= height:
                    drops[i] = 0
                    trail_lengths[i] = random.randint(MIN_TAIL, MAX_TAIL)
                    active_rick[i] = 1 if random.random() > 0.98 else 0

            # Show current FPS in the corner (optional, very 'dev' style)
            stdscr.addstr(0, 0, f" SPEED: {fps} ", curses.color_pair(1))
            stdscr.refresh()

        # --- DISSOLVE EXIT ---
        stdscr.timeout(30)
        for _ in range(height + MAX_TAIL):
            for i in range(width):
                y, tl = drops[i], trail_lengths[i]
                if 0 <= y - tl < height - 1:
                    stdscr.addch(y - tl, i, ' ')
                if 0 <= y < height - 1:
                    stdscr.addch(y, i, random.choice(chars), curses.color_pair(1))
                drops[i] += 1
            stdscr.refresh()
            stdscr.getch()

    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    curses.wrapper(draw_matrix)
