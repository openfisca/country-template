# Developed by corrado-petrelli and LorenzoStacchioDev
# Tested in Ubuntu, Debian and Windows 10
from Tkinter import Tk, Scrollbar, RIGHT, Y, Listbox, SINGLE, Button, BOTH, END, ACTIVE
import os
import shutil
import time
import sys
from subprocess import check_output

COUNTRY_LIST = ['Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua_and_Deps', 'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 'Bosnia_Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Cape_Verde', 'Central_African_Rep', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo', 'Congo_Democratic_Rep', 'Costa_Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech_Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican_Republic', 'East_Timor', 'Ecuador', 'Egypt', 'El_Salvador', 'Equatorial_Guinea', 'Eritrea', 'Estonia', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland_Republic', 'Israel', 'Italy', 'Ivory_Coast', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Korea_North', 'Korea_South', 'Kosovo', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein',
                'Lithuania', 'Luxembourg', 'Macedonia', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall_Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar_Burma', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'New_Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Panama', 'Papua_New_Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russian_Federation', 'Rwanda', 'St_Kitts_and_Nevis', 'St_Lucia', 'Saint_Vincent_and_the_Grenadines', 'Samoa', 'San_Marino', 'Sao_Tome_and_Principe', 'Saudi_Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra_Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon_Islands', 'Somalia', 'South_Africa', 'South_Sudan', 'Spain', 'Sri_Lanka', 'Sudan', 'Suriname', 'Swaziland', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Togo', 'Tonga', 'Trinidad_and_Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine', 'United_Arab_Emirates', 'United_Kingdom', 'United_States', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican_City', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe']


# function select item
def selectItem():
    item = listbox.curselection()
    # Continue only if there is a selected item else do nothing
    if(len(item) != 0):
        selectedCountry = str(COUNTRY_LIST[int(item[0])])
        # cut the escape sequence
        selectedCountry = selectedCountry.replace("\n", "")
        cloneAndAdapt(selectedCountry)


# Replace all occurrency of oldString to newString into all files into listOfFile
def replaceIntoListOfFile(listOfFile, oldString, newString):
    for nomeFile in listOfFile:
        with open(nomeFile, 'r') as file:
            fileLines = file.readlines()
        # Replace the target string
        fileLines = map(lambda x: str.replace(
            x, oldString, newString), fileLines)
        with open(nomeFile, 'w') as file:
            file.writelines(fileLines)


# The script's core
def cloneAndAdapt(item):
    # Nome dello stato
    COUNTRY_NAME = item
    # lower case
    lowercase_country_name = COUNTRY_NAME.lower()
    # Url (https://imgur.com/a/4zeXA)
    URL = "https://github.com/openfisca/openfisca-" + lowercase_country_name.replace("_", "-")
    # check if directory exists the script ends
    if os.path.isdir("openfisca-" + lowercase_country_name):
        sys.exit()
    # you must have install GIT for use this code
    check_output("git clone https://github.com/openfisca/country-template.git", shell=True).decode()
    shutil.move("country-template", "openfisca-" + lowercase_country_name)
    # create directory
    os.chdir("openfisca-" + lowercase_country_name)
    check_output("git remote remove origin", shell=True).decode()
    # ***********SED PART*******************
    # sed -i '3,28d' README.md
    with open('README.md', 'r') as file:
        fileLines = file.readlines()
    del fileLines[2:27]  # delete from 3rd line to 28th line
    with open('README.md', 'w') as file:
        file.writelines(fileLines)
    # sed -i '' "s|country_template|$lowercase_country_name|g" README.md setup.py check-version-bump.sh Makefile `find openfisca_country_template -type f`
    lista = ['README.md', 'setup.py', 'check-version-bump.sh', 'Makefile']
    for path, subdirs, files in os.walk("openfisca_country_template"):
        for name in files:
            lista.append(os.path.join(path, name))
    replaceIntoListOfFile(lista, "country_template", lowercase_country_name)
    # sed -i "s|country-template|$lowercase_country_name|g" README.md
    replaceIntoListOfFile([lista[0]], "country_template",
                          lowercase_country_name)
    # sed -i "s|Country-Template|$COUNTRY_NAME|g" README.md setup.py check-version-bump.sh .github/PULL_REQUEST_TEMPLATE.md CONTRIBUTING.md `find openfisca_country_template -type f`
    lista.remove('Makefile')
    lista.append('.github/PULL_REQUEST_TEMPLATE.md')
    lista.append('CONTRIBUTING.md')
    replaceIntoListOfFile(lista, "Country-Template", COUNTRY_NAME)
    # sed -i "s|https://github.com/openfisca/openfisca-country-template|$URL|g" setup.py
    replaceIntoListOfFile([lista[1]], "https://github.com/openfisca/openfisca-country-template", URL)
    # mv openfisca_country_template openfisca_$lowercase_country_name
    shutil.move("openfisca_country_template", "openfisca_" + lowercase_country_name)
    # close window
    root.quit()


# *********VARIABLES*********
selectedCountry = ""
root = Tk()
scrollBar = Scrollbar(root)
listbox = Listbox(root, selectmode=SINGLE, yscrollcommand = scrollBar.set)
btnSend = Button(root, text="Choose selected country", state=ACTIVE)
# *********ROOT*********
root.title("Choose a country")
root.geometry('300x200')
root.resizable(False, False)
# *********SCROLLBAR*********
scrollBar.config(command = listbox.yview)
scrollBar.pack(side = RIGHT, fill = Y)
# *********LISTBOX*********
listbox.config(selectbackground="#FA8072")
listbox.pack(fill=BOTH, expand=1)
# Inject country in listbox
for country in COUNTRY_LIST:
    listbox.insert(END, country)
# *********BUTTON*********
btnSend.pack(fill=BOTH)
btnSend.config(command=selectItem)
itemChoose = listbox.curselection()
root.mainloop()
