require 'json'
require 'open-uri'

class HtmlGenerator

	def index
		puts "HtmlGenerator: index"

		raw_response = open("http://lcboapi.com/products").read
		# Parse JSON­formatted text into a Ruby Hash
		parsed_response = JSON.parse(raw_response)

		# Return the actual result data from the response, ignoring metadata
		products = parsed_response["result"]

		#runs the header method for the start of the html page
		File.open("index.html", "w") do |f|

		f.puts("<html>")
			f.puts("<link rel='stylesheet' type='text/css' href='styles.css'>")
			f.puts("<head>")
			f.puts("	<title>LCBO Demo</title>")
			f.puts("</head>")

			f.puts("<body>")

		products.each do |product|


			f.puts "<div class='product'>"
		      f.puts "  <h2>#{product['name']}</h2>"
		      f.puts "  <img src='#{product['image_thumb_url']}'  class='product-thumbnail'/>"
		      f.puts "  <ul class='product-list'>"
		      f.puts "    <li>id: #{product['id']}</li>"
		      f.puts "    <li>#{product['producer_name']}</li>"
		      f.puts "    <li>#{product['primary_category']}</li>"
		      f.puts "    <li>#{product['secondary_category']}</li>"
		      f.puts "    <li>#{product['volume_in_milliliters']} ml</li>"
		      f.puts "    <li>#{product['total_package_units']} </li>"
		      f.puts "    <li>$#{to_cents(product['price_in_cents'])}</li>"
		      f.puts "  </ul>"
		    f.puts "</div>"
	    end

	     f.puts "  </body>"
	    f.puts "</html>"


    end
  end



	def show(product_id)

		#pulls date only from certain product id
		raw_response = open("http://lcboapi.com/products/#[product_id]").read
		# Parse JSON­formatted text into a Ruby Hash
		parsed_response = JSON.parse(raw_response)

		# Return the actual result data from the response, ignoring metadata
		product = parsed_response

		File.open("show.html", "w") do |f|

		f.puts("<html>")
			f.puts("<link rel='stylesheet' type='text/css' href='styles_show.css'>")
			f.puts("<head>")
			f.puts("	<title>LCBO </title>")
			f.puts("</head>")

			f.puts("<body>")

			#why isnt this pushing in



		f.puts "<div class='product'>"
		      f.puts "  <h2>#{product['name']}</h2>"
		      f.puts "  <img src='#{product['image_url']}'  class='product-image'/>"
		      f.puts "  <ul class='product-list'>"
		      f.puts "    <li>id: #{product['id']}</li>"
		      f.puts "    <li>#{product['producer_name']}</li>"
		      f.puts "    <li>#{product['primary_category']}</li>"
		      f.puts "    <li>#{product['secondary_category']}</li>"
		      f.puts "    <li>#{product['volume_in_milliliters']} ml</li>"
		      f.puts "    <li>#{product['total_package_units']} </li>"
		      f.puts "    <li>$#{to_cents(product['price_in_cents'])}</li>"
		      f.puts "  </ul>"
		  f.puts "</div>"


		 f.puts "  </body>"
	    f.puts "</html>"

	    puts

	    end
	end




	def to_cents(cents_string)
	    cents_string.to_f/100
    end

end
