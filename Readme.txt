Title: 

How to use the converter from XML to CSV file formats.


Description: 

The process extracts the data from the xml file and gets the csv output file 
by using the xslt file and the xslt processor written in Java.

Getting started:

	- Install Java version 17+ on the computer you will use to run the process.
	

Assumptions:

- The file will be ready to be imported to Excel, the fields will be between qoutes. The numeric and date fields 
	don't have a problem if they are double quoted when imported.
- Only Include Employee Status Active and OnLeave, The integration design only mentions these two
- I am using XSLT 1.0 in preparation for the conversion processed to be run using Java.
- I changed employee ID 00000281780 status to OnLeave to show that the process works with Employees with Status OnLeave.
- For now the only shell program included is to run on Linux environments, but you can create a shell/batch file to run it 
	in any other environment, it will run like this:
	java -jar ./XsltTransform.jar ElegibilityEmployeesDataToCSV.xslt EmployeesData.xml ${OUTPUTFILENAME}
	OUTPUTFILENAME must be filename.csv
- You must have ksh installed.

Installing:

	- Copy all files to a folder, like /tmp
	- Open a terminal in the folder you stored the files.
	- Ensure you can execute the shell file, run: chmod +x ElegibilityEmployeesDataToCSV.ksh 
	
Executing the program:

	- Open a terminal in the folder you have all the files.
	- execute the next command: ./ElegibilityEmployeesDataToCSV.ksh
	This will generate the csv file. You only need to list your files and you will see the csv generated.
	

Help:

	Send email to: laran.ikal@gmail.com

Authors:

	Carlos Kassab => laran.ikal@gmail.com

Version History:

	- 0.1 First Release.
	
License:

	This project is under MIT license:
	
	
MIT License

Copyright (c) 2025 Carlos Kassab

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

