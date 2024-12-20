# https://www.malachid.com/blog/2018-08-31-currency/
module Jekyll
  module Money
    def format_price(value, type="span", separator=",")
      readable = sprintf("%.2f", value.abs).split('.')
      readable[0] = readable[0].gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{separator}")
      if value < 0
        "<#{type} class=\"monetary monetary_positive\">(#{readable.join('.')})</#{type}>"
      else
        "<#{type} class=\"monetary monetary_negative\">#{readable.join('.')}</#{type}>"
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Money)
