import datetime

from utils import get_iso_8601_string, extract_date


def generate_timestamp(iso_string_8601=get_iso_8601_string()):
    """((2025//(07|Jul)//(21|Mon)||((02:13|PM)|14:13):26.219))"""

    date_extracted = extract_date(iso_string_8601)
    yyyy = date_extracted["yyyy"]
    mm = date_extracted["mm"]
    mmm = date_extracted["mmm"]
    dd = date_extracted["dd"]
    ddd = date_extracted["ddd"]
    hhmm12 = date_extracted["hhmm12"]
    ampm = date_extracted["ampm"]
    hhmm24 = date_extracted["hhmm24"]
    ss = date_extracted["ss"]
    ms = date_extracted["ms"]
    print(f"(({yyyy}//({mm}|{mmm})//({dd}|{ddd})||(({hhmm12}|{ampm})|{hhmm24}):{ss}.{ms}))")
    return (current_timestamp := datetime.datetime.now()).strftime(f"((%Y//(%m|%b)//(%d|%a)||((%I:%M|%p)|%H:%M):%S.{current_timestamp.microsecond // 1000:03d}))")


def generate_timestamp(precise=False):
    if precise:
        # ((2025//(07|Jul)//(21|Mon)||(02:13 PM|14:13):26.219000))
        return datetime.datetime.now().strftime("((%Y//(%m|%b)//(%d|%a)||((%I:%M %p|%H:%M):%S.%f)))")
    # ((2025//(07|Jul)//(21|Mon)||(02:13 PM|14:13)))
    return datetime.datetime.now().strftime("((%Y//(%m|%b)//(%d|%a)||(%I:%M %p|%H:%M)))")


def generate_timestamp(precise=False):
    full_year, zero_padded_month, month_three_first_letter, zero_padded_day, day_three_first_letter, zero_padded_hour_twelve_hour_clock, am_pm, zero_padded_hour_twenty_four_hour_clock, zero_padded_minute, zero_padded_second, zero_padded_mili_second_three_digit = extract_date()


if __name__ == "__main__":
    print(generate_timestamp())
    print(generate_timestamp(True))
