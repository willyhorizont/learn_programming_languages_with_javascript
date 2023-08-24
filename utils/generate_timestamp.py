import datetime


def generate_timestamp(seconds: bool = False):
    my_datetime_format = [
        '%H:%M:%S | %I:%M:%S %p | %a | %b | %d/%m/%Y',  # 17:56:00 | 05:56:00 PM | Fri | Jul | 28/07/2023
        '%H:%M | %I:%M %p | %a | %b | %d/%m/%Y'  # 17:56 | 05:56 PM | Fri | Jul | 28/07/2023
    ]
    return datetime.datetime.now().strftime(my_datetime_format[0] if seconds == True else my_datetime_format[1])


if __name__ == '__main__':
    print(generate_timestamp(seconds=True))
    print(generate_timestamp())
