
def to_pounds(int_amount)
  pounds = int_amount/100.00
  "%.2f" % pounds
end

def to_pennies(str_amount)
  pennies = (str_amount.to_f) * 100
  pennies.round(0).to_s
end

def to_uk_date(date)
  date.strftime('%d-%m-%Y')
end
