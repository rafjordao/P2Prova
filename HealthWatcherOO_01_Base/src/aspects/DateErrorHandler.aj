package aspects;

import lib.exceptions.InvalidDateException;
import lib.util.Date;
import lib.util.Schedule;

public privileged aspect DateErrorHandler {
	// Schedule
	pointcut Schedule_init(): initialization(Schedule.new(String, String, String));
	pointcut Schedule_stringToHorario(): execution(public Schedule Schedule.stringToHorario(String, int));
	
	// Date
	pointcut Date_init(): initialization(Date.new(..)) && !initialization(Date.new(int, int, int));
	pointcut Date_stringToData(): execution(public Date Date.stringToData(String, int));
	
	// Advices --------------------------------------------------------->
	
	after(Schedule s) throwing(NumberFormatException nfe) throws InvalidDateException: Schedule_init() && this(s) {
		throw new InvalidDateException(s.segundo, s.minuto, s.hora);
	}
	
	after(String horarioStr) throwing(Exception e) throws InvalidDateException: Schedule_stringToHorario() && args(horarioStr, *) {
		throw new InvalidDateException(horarioStr);
	}
	
	after(Date d) throwing(Exception e) throws InvalidDateException: Date_init() && this(d) {
		throw new InvalidDateException(d.dia, d.mes, d.ano);
	}
	
	after(String dataStr) throwing(Exception e) throws InvalidDateException: Date_stringToData() && args(dataStr, *) {
		throw new InvalidDateException(dataStr);
	}
}