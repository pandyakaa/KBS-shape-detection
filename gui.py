import tkinter as tk
from tkinter import filedialog
from tkinter import ttk
import os

root = tk.Tk()
root.title('Tubes 2 AI')

# ================================= API ================================= #


def open_source_image():
    my_filetypes = [('png files', '.png'), ('gif files',
                                            '.gif')]
    answer = filedialog.askopenfilenames(parent=topframe,
                                         initialdir=os.getcwd(),
                                         title="Please select one or more files:",
                                         filetypes=my_filetypes)
    return answer


def show_source_image():
    path = open_source_image()
    if path == '':
        pass
    else:
        img = tk.PhotoImage(file=path)
        l1 = tk.Label(sourceimagecanvas, image=img)
        l1.image = img
        sourceimagecanvas.create_image(175, 150, image=l1.image)


def show_rule_editor():
    rule_editor = tk.Toplevel()
    rule_editor.title('Rule Editor')
    rule_editor.mainloop()


def show_rules():
    rules = tk.Toplevel()
    rules.title('Rules')
    rules.mainloop()


def show_facts():
    hit_rule = tk.Toplevel()
    hit_rule.title('Facts')
    hit_rule.mainloop()


def OnDoubleClick(event):
    item = tree.selection()[0]
    path = os.getcwd() + '/assets/' + item + '.png'

    img = tk.PhotoImage(file=path)
    l1 = tk.Label(sourceimagecanvas, image=img)
    l1.image = img
    detectionimagecanvas.create_image(175, 150, image=l1.image)

# ================================= Top frame ================================= #
topframe = tk.Frame(root)
topframe.grid(row=0, column=0)

# ================= TopLeft frame ================= #

# 'Source Image' frame
sourceimageframe = tk.Frame(topframe)
sourceimageframe.grid(row=0, column=0)

# 'Source Image' label
sourceimagelabel = tk.Label(sourceimageframe, text='Source Image')
sourceimagelabel.grid(pady=5)

# 'Source Image' canvas
sourceimagecanvas = tk.Canvas(
    sourceimageframe, width=350, height=300, background='white')
sourceimagecanvas.grid(padx=5, pady=5)

sourceimagecanvas.create_text(175, 150, font="Arial 12 bold",
                              text="Please open an image")
sourceimagecanvas.create_text(175, 175, font="Arial 8 bold",
                              text="Click \"Open Image\" Button")

# ================= TopMid frame ================= #

# 'Detection Image' frame
detectionimageframe = tk.Frame(topframe)
detectionimageframe.grid(row=0, column=1)

# 'Detection Image' label
detectionimagelabel = tk.Label(detectionimageframe, text='Detection Image')
detectionimagelabel.grid(pady=5)

# 'Detection Image' canvas
detectionimagecanvas = tk.Canvas(
    detectionimageframe, width=350, height=300, background='white')
detectionimagecanvas.grid(padx=5, pady=5)

detectionimagecanvas.create_text(175, 150, font="Arial 12 bold",
                                 text="Please choose a shape")
detectionimagecanvas.create_text(175, 175, font="Arial 8 bold",
                                 text="Double Click Shape Tree Item")

# ================= TopRight frame ================= #

# ========= 'Menu' frame =========
menuframe = tk.Frame(topframe)
menuframe.grid(row=0, column=2, padx=5)

# ==== 'Menu Button' frame ====
menubuttonframe = tk.Frame(menuframe)
menubuttonframe.grid(row=0, column=0, pady=2)

# == 'Open Image' button ==
openimagebutton = tk.Button(
    menubuttonframe, text='Open Image', width=20, command=show_source_image)
openimagebutton.grid(row=0, column=0, pady=4)

# == 'Open Rule Editor' button ==
openruleeditorbutton = tk.Button(
    menubuttonframe, text='Open Rule Editor Button', width=20, command=show_rule_editor)
openruleeditorbutton.grid(row=1, column=0, pady=4)

# == 'Show Rules Editor' button ==
showrulesbutton = tk.Button(menubuttonframe, text='Show Rules', width=20, command=show_rules)
showrulesbutton.grid(row=2, column=0, pady=4)

# == 'Show Facts Editor' button ==
showfactsbutton = tk.Button(menubuttonframe, text='Show Facts', width=20, command=show_facts)
showfactsbutton.grid(row=3, column=0, pady=4)

# ==== 'Shape Menu' frame ====
menushapeframe = tk.Frame(menuframe)
menushapeframe.grid(row=1, column=0, pady=3)

# ==== 'Shape Menu' label ====
shapelabel = tk.Label(menushapeframe, text='What shape do you want ?')
shapelabel.grid()

# ==== 'Shape Menu' canvas ====
shapecanvas = tk.Canvas(menushapeframe, height=150,
                        width=150, background='white')
shapecanvas.grid(row=4, column=0, pady=4)

# == 'Shape Menu' tree ==
tree = ttk.Treeview(menushapeframe, height=7)
tree.column('#0')
tree.heading('#0', text='Shapes')
tree.grid(row=4, column=0, pady=4)
tree.bind("<Double-1>",OnDoubleClick)

# All Shape, tree level 0
allshape = tree.insert('', 0, 'allshape', text="All Shape")

# Triangle, tree level 1
triangle = tree.insert(allshape, 0, 'triangle', text='Triangle')
acutetriangle = tree.insert(
    triangle, 0, 'acutetriangle', text='Acute Triangle', values=(show_source_image))
obtusetriangle = tree.insert(
    triangle, 1, 'obtusetriangle', text='Obtuse Triangle')
righttriangle = tree.insert(
    triangle, 2, 'righttriangle', text='Right Triangle')
isoscelestriangle = tree.insert(
    triangle, 3, 'isoscelestriangle', text='Isosceles Triangle')
equilateraltriangle = tree.insert(
    triangle, 4, 'equilateraltriangle', text='Equilateral Triangle')

# Isosceles triangle, tree level 2
isoscelestriangle_right = tree.insert(
    isoscelestriangle, 0, 'isoscelestriangle_right', text='Right Isosceles Triangle')
isoscelestriangle_obtuse = tree.insert(
    isoscelestriangle, 1, 'isoscelestriangle_obtuse', text='Obtuse Isosceles Triangle')
isoscelestriangle_acute = tree.insert(
    isoscelestriangle, 2, 'isoscelestriangle_acute', text='Acute Isosceles Triangle')

# Quadrillateral, tree level 1
quadrillateral = tree.insert(
    allshape, 1, 'quadrillateral', text='Quadrillateral')
paralellogram = tree.insert(quadrillateral, 0, text='Parallelogram')
trapesium = tree.insert(quadrillateral, 1, text='Trapesium')

# Parallelogram, tree level 2
rectangle = tree.insert(paralellogram, 0, text='Rectangle')
kite = tree.insert(paralellogram, 1, text='Kite')

# Trapesium, tree level 2
isoscelestrapesium = tree.insert(trapesium, 0, text='Isosceles Trapesium')
rightsidedtrapesium = tree.insert(trapesium, 1, text='Right Sided Trapesium')
leftsidedtrapesium = tree.insert(trapesium, 2, text='Left Sided Trapesium')

# Pentagon, tree level 1
pentagon = tree.insert(allshape, 2, 'pentagon', text='Pentagon')

# Pentagon Five Sided, tree level 2
pentagon_five_sided = tree.insert(
    pentagon, 0, 'pentagon_five_sided', text='Pentagon Five Sided')

# Hexagon, tree level 1
hexagon = tree.insert(allshape, 3, 'hexagon', text='Hexagon')

# Hexagon Six Sided, tree level 2
hexagon_six_sided = tree.insert(
    hexagon, 0, 'hexagon_six_sided', text='Hexagon Six Sided')

tree.grid()

# ================================= Bottom frame ================================= #
bottomframe = tk.Frame(root)
bottomframe.grid(row=1, column=0)

# ================= BottomLeft frame ================= #

# ========= 'Detection Result' frame =========
detectionresultframe = tk.Frame(bottomframe)
detectionresultframe.grid(row=0, column=0)

# ========= 'Detection Result' label =========
detectionresultlabel = tk.Label(detectionresultframe, text='Detection Result')
detectionresultlabel.grid(pady=5)

# ========= 'Detection Result' canvas =========
detectionresultcanvas = tk.Canvas(
    detectionresultframe, width=300, height=300, background='white')
detectionresultcanvas.grid(padx=5, pady=5)

# ================= BottomMid frame ================= #

# ========= 'Matched Facts' frame =========
matchedfactsframe = tk.Frame(bottomframe)
matchedfactsframe.grid(row=0, column=1)

# ========= 'Matched Facts' label =========
matchedfactslabel = tk.Label(matchedfactsframe, text='Matched Facts')
matchedfactslabel.grid(pady=5)

# ========= 'Matched Facts' canvas =========
matchedfactscanvas = tk.Canvas(
    matchedfactsframe, width=300, height=300, background='white')
matchedfactscanvas.grid(padx=5, pady=5)

# ================= BottomRight frame ================= #

# ========= 'Hit Rules' frame =========
hitrulesframe = tk.Frame(bottomframe)
hitrulesframe.grid(row=0, column=2)

# ========= 'Hit Rules' label =========
hitruleslabel = tk.Label(hitrulesframe, text='Hit Rules')
hitruleslabel.grid(pady=5)

# ========= 'Hit Rules' canvas =========
hitrulescanvas = tk.Canvas(hitrulesframe, width=300,
                           height=300, background='white')
hitrulescanvas.grid(padx=5, pady=5)

# ================================= Main Loop ================================= #
root.mainloop()
