@system Weather begin
    calendar(context) ~ ::Calendar
    w ~ provide(index=:DATE, init=calendar.date, parameter)

    DATE ~ drive::date(from=w)
    TMAX: maximum_temperature ~ drive(from=w, u"°C")
    TMIN: minimum_temperature ~ drive(from=w, u"°C")
    RAIN: rainfall ~ drive(from=w, u"mm/d")

    SRAD ~ drive(from=w, u"MJ/m^2/d")
    PAR(SRAD) => 0.5 * SRAD ~ track(u"MJ/m^2/d")
end