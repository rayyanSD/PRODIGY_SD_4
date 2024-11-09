import requests
from bs4 import BeautifulSoup
import csv

# Set the URL of the website to scrape
URL = 'https://www.example.com/products'  # Replace this with the actual URL
HEADERS = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'}

# Function to extract product information
def get_product_data(url):
    # Send a GET request to the website
    response = requests.get(url, headers=HEADERS)
    
    if response.status_code != 200:
        print("Failed to retrieve the web page")
        return []
    
    # Parse the HTML content using BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')

    # Extract product names, prices, and ratings
    products = []
    
    # Example of how to extract data (modify selectors based on the actual website structure)
    product_list = soup.find_all('div', class_='product')  # Modify the tag and class name

    for product in product_list:
        name = product.find('h2', class_='product-name').text.strip()  # Modify tag and class
        price = product.find('span', class_='price').text.strip()  # Modify tag and class
        rating = product.find('span', class_='rating').text.strip() if product.find('span', class_='rating') else 'No rating'
        
        products.append([name, price, rating])

    return products

# Function to save data to CSV
def save_to_csv(data, filename='products.csv'):
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['Product Name', 'Price', 'Rating'])  # Write header row
        writer.writerows(data)
    print(f"Data saved to {filename}")

# Main function to run the scraper
def main():
    print("Starting the product data extraction...")
    
    # Get product data from the website
    product_data = get_product_data(URL)
    
    if product_data:
        # Save the extracted data to a CSV file
        save_to_csv(product_data)
    else:
        print("No product data found.")

if __name__ == "__main__":
    main()
