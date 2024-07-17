#' Combine Visual Field PDFs
#'
#' This function reads visual field data from a CSV file, generates individual PDFs,
#' converts them to images, combines them side by side, and saves them as a new PDF file
#' with multiple pages.
#'
#' @param file_source The directory where the CSV file is located.
#' @param number_from_OE An integer to index the visual field data.
#' @param file_names A vector of filenames for the generated PDFs.
#' @return The path to the combined PDF file.
#' @export
#' @import visualFields
#' @import pdftools
#' @import magick
combine_visual_field_pdfs <- function(file_source, number_from_OE, file_names) {
  # Set working directory
  setwd(file_source)

  # Read the CSV file
  vf <- read.csv("VField Data from Olleyes CSV.csv",
                 colClasses = c("date" = "Date", "Variation" = "NULL",
                                "Patient_ID" = "NULL", "First_Name" = "NULL",
                                "Last_Name" = "NULL", "DOB" = "NULL", "Ethnicity" = "NULL",
                                "Gender" = "NULL", "Goldmann" = "NULL",
                                "MD" = "NULL", "PSD" = "NULL"))

  # Generate individual PDFs
  for (i in seq_along(file_names)) {
    filename <- paste0(i, ". ", file_names[i], ".pdf")
    vfsfa(vf[number_from_OE + i, ], filename)
  }

  # List of generated PDF files
  pdf_files <- paste0(seq_along(file_names), ". ", file_names, ".pdf")

  # Convert PDF pages to images
  images <- lapply(pdf_files, function(pdf) {
    pdf_convert(pdf, format = "png", pages = 1)
  })

  # Read the images
  image_list <- lapply(images, image_read)

  # Combine images side by side for each pair
  combined_images <- list()
  for (i in seq(1, length(image_list), by = 2)) {
    combined_image <- image_append(c(image_list[[i]], image_list[[i + 1]]), stack = FALSE)
    combined_images <- c(combined_images, list(combined_image))
  }

  # Save combined images as a new PDF file with multiple pages
  combined_pdf_path <- "Combined_Olleyes_vFields.pdf"
  image_write(image_join(combined_images), path = combined_pdf_path, format = "pdf")

  # Clean up temporary image and PDF files
  file.remove(c(unlist(images), pdf_files))

  return(combined_pdf_path)
}
