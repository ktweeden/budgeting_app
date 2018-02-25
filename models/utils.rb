
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

def month_info(month_str)
  months = {
    'jan' => { num: '01', length: '31'},
    'feb' => { num: '02', length: '28'},
    'mar' => { num: '03', length: '31'},
    'apr' => { num: '04', length: '30'},
    'may' => { num: '05', length: '31'},
    'jun' => { num: '06', length: '30'},
    'jul' => { num: '07', length: '31'},
    'aug' => { num: '08', length: '31'},
    'sep' => { num: '09', length: '30'},
    'oct' => { num: '10', length: '31'},
    'nov' => { num: '11', length: '30'},
    'dec' => { num: '12', length: '31'},
  }
  result = {'month' => months[month_str][:num], 'length' => months[month_str][:length]}
end

def is_negative?(number_str)
  number_str.to_i < 0
end
