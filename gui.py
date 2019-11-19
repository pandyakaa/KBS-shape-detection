import tkinter as tk

root = tk.Tk()
root.title('Tubes 2 AI')

# ================================= Top frame ================================= #
topframe = tk.Frame(root)
topframe.grid(row=0, column=0)

# TopLeft frame
sourceimageframe = tk.Frame(topframe)
sourceimageframe.grid(row=0, column=0)

sourceimagelabel = tk.Label(sourceimageframe, text='Source Image')
sourceimagelabel.grid(pady=5)

sourceimagecanvas = tk.Canvas(
    sourceimageframe, width=350, height=300, background='white')
sourceimagecanvas.grid(padx=5, pady=5)

sourceimagecanvas.create_text(175, 150, font="Arial 12 bold",
                              text="Please open an image")
sourceimagecanvas.create_text(175, 175, font="Arial 8 bold",
                              text="Click \"Open Image\" Button")

# TopMid frame
detectionimageframe = tk.Frame(topframe)
detectionimageframe.grid(row=0, column=1)

detectionimagelabel = tk.Label(detectionimageframe, text='Detection Image')
detectionimagelabel.grid(pady=5)

detectionimagecanvas = tk.Canvas(
    detectionimageframe, width=350, height=300, background='white')
detectionimagecanvas.grid(padx=5, pady=5)

detectionimagecanvas.create_text(175, 150, font="Arial 12 bold",
                                 text="Please choose a shape")
detectionimagecanvas.create_text(175, 175, font="Arial 8 bold",
                                 text="Double Click Shape Tree Item")

# TopRight frame
menuframe = tk.Frame(topframe)
menuframe.grid(row=0, column=2, padx=5)

openimagebutton = tk.Button(menuframe, text='Open Image', width=20)
openimagebutton.grid(row=0, column=0, pady=4)

openruleeditorbutton = tk.Button(
    menuframe, text='Open Rule Editor Button', width=20)
openruleeditorbutton.grid(row=1, column=0, pady=4)

showrulesbutton = tk.Button(menuframe, text='Show Rules', width=20)
showrulesbutton.grid(row=2, column=0, pady=4)

showfactsbutton = tk.Button(menuframe, text='Show Facts', width=20)
showfactsbutton.grid(row=3, column=0, pady=4)

shapecanvas = tk.Canvas(menuframe, height=190, width=150, background='white')
shapecanvas.grid(row=4, column=0, pady=4)

# ================================= Bottom frame ================================= #
bottomframe = tk.Frame(root)
bottomframe.grid(row=1, column=0)

# BottomLeft frame
detectionresultframe = tk.Frame(bottomframe)
detectionresultframe.grid(row=0, column=0)

detectionresultlabel = tk.Label(detectionresultframe, text='Detection Result')
detectionresultlabel.grid(pady=5)

detectionresultcanvas = tk.Canvas(
    detectionresultframe, width=300, height=300, background='white')
detectionresultcanvas.grid(padx=5, pady=5)

# BottomMid frame
matchedfactsframe = tk.Frame(bottomframe)
matchedfactsframe.grid(row=0, column=1)

matchedfactslabel = tk.Label(matchedfactsframe, text='Matched Facts')
matchedfactslabel.grid(pady=5)

matchedfactscanvas = tk.Canvas(
    matchedfactsframe, width=300, height=300, background='white')
matchedfactscanvas.grid(padx=5, pady=5)

# BottomRight frame
hitrulesframe = tk.Frame(bottomframe)
hitrulesframe.grid(row=0, column=2)

hitruleslabel = tk.Label(hitrulesframe, text='Hit Rules')
hitruleslabel.grid(pady=5)

hitrulescanvas = tk.Canvas(hitrulesframe, width=300,
                           height=300, background='white')
hitrulescanvas.grid(padx=5, pady=5)

# ================================= Main Loop ================================= #
root.mainloop()
