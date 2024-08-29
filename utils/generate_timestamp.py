import datetime


def generate_timestamp(style_in_int: int = 0):
    my_datetime_format = [
        '%H:%M:%S | %I:%M:%S %p | %a | %b | %d/%m/%Y',  # 05:45:29 | 05:45:29 AM | Fri | Aug | 30/08/2024
        '%H:%M | %I:%M %p | %a | %b | %d/%m/%Y',  # 05:45 | 05:45 AM | Fri | Aug | 30/08/2024
        '%H:%M/%I:%M%p|%Y/%m[%b]/%d[%a]',  # 05:45/05:45AM|2024/08[Aug]/30[Fri]
        '(%Y/%m[%b]/%d[%a]|%I:%M[%p]/%H:%M)',  # (2024/08[Aug]/30[Fri]|05:47[AM]/05:47)
    ]
    return datetime.datetime.now().strftime(my_datetime_format[style_in_int])


if __name__ == '__main__':
    print(generate_timestamp(0))
    print(generate_timestamp(1))
    print(generate_timestamp(2))
    print(generate_timestamp(3))
