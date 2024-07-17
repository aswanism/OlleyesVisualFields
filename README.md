How to use this package?

# Step 1: Prepare PNG file
a. Download and save Olleyes result in png format. Make sure download only 1 test at a time.
b. Unzip file.
c. Open the folder and you can see 2 png files (page_01.png & page_02.png). Keep the names as they are.


# Step 2 Install Packages
a. Install these 2 packages before you proceed to the next step:
   i. install.packages("devtools")
   ii. install.packages("magick")
   iii. install.packages("pdftools")
   iv. install.packages("visualFields")

b. Install "myVisualFieldsPackage" by typing in these code and run it:

   library(devtools)
   install.github("aswanism/OlleyesVisualFields")


# Step 3. Use myVisualFieldsPackage package
a. Use this script to generate your pdf files:

library(myVisualFieldPackage)
library(visualFields)
library(pdftools)
library(magick)

file_source <- "path/to/your/folder"
olleyes_file_csv <- "Your_Olleyes_File.csv" #this file is inside file_source
number_from_OE <- 74 # 1 number before acquired data
file_names <- c("JS_vFields_21-7-23_OD", 
                "JS_vFields_21-7-23_OS", 
                "JS_vFields_22-7-23_OD", 
                "JS_vFields_22-7-23_OS", 
                "JS_vFields_23-7-23_OD", 
                "JS_vFields_23-7-23_OS")

combined_pdf_path <- combine_visual_field_pdfs(file_source, olleyes_file_csv, number_from_OE, file_names)

print(paste("Combined PDF saved at:", combined_pdf_path))
