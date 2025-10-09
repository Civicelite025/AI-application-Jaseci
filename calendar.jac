"""A Simple Calendar Generator in JAC"""

import calendar

node CalendarNode {
    has year: int;
    has month: int;
    has calendar_text: str;

    can generate entry {
        calendar_text = calendar.month(year, month);
        print(f"\n📅 Calendar for {calendar.month_name[month]} {year}:\n");
        print(calendar_text);
    }
}

walker CalendarCreator {
    has year: int;
    has month: int;

    can start entry {
        print("🗓️ Welcome to the Calendar Generator!");
        year = int(input("Enter year (e.g., 2025): "));
        month = int(input("Enter month (1–12): "));

        spawn here with create_calendar;
    }

    can create_calendar entry {
        # Create a CalendarNode and trigger its generator
        node calendar_node = spawn CalendarNode(year=year, month=month);
        calendar_node.generate();
        print("✅ Calendar successfully created!\n");
    }
}

with entry __main__ {
    root.spawn(CalendarCreator());
}
