import datetime
import calendar

from utils import get_type, any_type


def extract_date(iso_string_8601=None):
    if iso_string_8601 is None:
        iso_string_8601 = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="milliseconds").replace("+00:00", "Z")

    timestamp = datetime.datetime.fromisoformat(iso_string_8601.replace("Z", "+00:00"))

    hh = timestamp.hour
    mm_min = f"{timestamp.minute:02}"
    hh12 = ((hh % 12) or 12)

    yyyy = timestamp.year
    mm = f"{timestamp.month:02}"
    mmm = calendar.month_abbr[timestamp.month]
    dd = f"{timestamp.day:02}"
    ddd = calendar.day_abbr[timestamp.weekday()]
    hhmm12 = f"{hh12:02}:{mm_min}"
    ampm = ("AM" if (hh < 12) else "PM")
    hhmm24 = f"{hh:02}:{mm_min}"
    ss = f"{timestamp.second:02}"
    ms = int(timestamp.microsecond / 1000)

    return {"yyyy": yyyy, "mm": mm, "mmm": mmm, "dd": dd, "ddd": ddd, "hhmm12": hhmm12, "ampm": ampm, "hhmm24": hhmm24, "ss": ss, "ms": ms}


def extract_date(anything):
    anything_type = get_type(anything)
    any_date = datetime.datetime.fromisoformat(anything.replace("Z", "+00:00")) if (anything_type == any_type["String"]) else (anything if (anything_type == any_type["Date"]) else None)
    if any_date is None:
        return

    timestamp = datetime.datetime.fromisoformat(anything.replace("Z", "+00:00"))

    hh = timestamp.hour
    hh12 = ((hh % 12) or 12)

    full_year = timestamp.year
    zero_padded_month = f"{timestamp.month:02}"
    month_three_first_letter = calendar.month_abbr[timestamp.month]
    zero_padded_day = f"{timestamp.day:02}"
    day_three_first_letter = calendar.day_abbr[timestamp.weekday()]
    zero_padded_hour_twelve_hour_clock = f"{hh12:02}"
    am_pm = ("AM" if (hh < 12) else "PM")
    zero_padded_hour_twenty_four_hour_clock = f"{hh:02}"
    zero_padded_minute = f"{timestamp.minute:02}"
    zero_padded_second = f"{timestamp.second:02}"
    zero_padded_mili_second_three_digit = int(timestamp.microsecond / 1000)

    return [full_year, zero_padded_month, month_three_first_letter, zero_padded_day, day_three_first_letter, zero_padded_hour_twelve_hour_clock, am_pm, zero_padded_hour_twenty_four_hour_clock, zero_padded_minute, zero_padded_second, zero_padded_mili_second_three_digit]


def main():
    print("# extract date in Python")

    date_extracted = extract_date(datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="milliseconds").replace("+00:00", "Z"))
    print(f'(({date_extracted["yyyy"]}//({date_extracted["mm"]}|{date_extracted["mmm"]})//({date_extracted["dd"]}|{date_extracted["ddd"]})||(({date_extracted["hhmm12"]}|{date_extracted["ampm"]})|{date_extracted["hhmm24"]}):{date_extracted["ss"]}.{date_extracted["ms"]}))')


if __name__ == "__main__":
    main()
