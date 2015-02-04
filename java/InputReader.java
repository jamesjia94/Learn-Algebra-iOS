/**
 * @author Thomas Liu
 * @since 01/08/13
 */
public class InputReader {
	
	/**
	 * Returns whether two equations are mathematically equivalent
	 */
	public static boolean compareEquations(String equation1, String equation2) {
		try {
			if (equation1.equals(equation2)) {
				return true;
			}
			equation1 = prepEquation(equation1);
			equation2 = prepEquation(equation2);
			if (equation1.equals(equation2)) {
				return true;
			}
			if (equation1.contains("<=")) {
				if (equation2.contains(">="))
					return (compareEquations(equation1.split("<=")[0],
							equation2.split(">=")[1]) && compareEquations(
							equation1.split("<=")[1], equation2.split(">=")[0]));
				if (equation2.contains("<="))
					return (compareEquations(equation1.split("<=")[0],
							equation2.split("<=")[0]) && compareEquations(
							equation1.split("<=")[1], equation2.split("<=")[1]));
			}
			if (equation1.contains(">=")) {
				if (equation2.contains("<="))
					return (compareEquations(equation1.split(">=")[0],
							equation2.split("<=")[1]) && compareEquations(
							equation1.split(">=")[1], equation2.split("<=")[0]));
				if (equation2.contains(">="))
					return (compareEquations(equation1.split(">=")[0],
							equation2.split(">=")[0]) && compareEquations(
							equation1.split(">=")[1], equation2.split(">=")[1]));
			}
			if (equation1.contains("<")) {
				if (equation2.contains(">"))
					return (compareEquations(equation1.split("<")[0],
							equation2.split(">")[1]) && compareEquations(
							equation1.split("<")[1], equation2.split(">")[0]));
				if (equation2.contains("<"))
					return (compareEquations(equation1.split("<")[0],
							equation2.split("<")[0]) && compareEquations(
							equation1.split("<")[1], equation2.split("<")[1]));
			}
			if (equation1.contains(">")) {
				if (equation2.contains("<"))
					return (compareEquations(equation1.split(">")[0],
							equation2.split("<")[1]) && compareEquations(
							equation1.split(">")[1], equation2.split("<")[0]));
				if (equation2.contains(">"))
					return (compareEquations(equation1.split(">")[0],
							equation2.split(">")[0]) && compareEquations(
							equation1.split(">")[1], equation2.split(">")[1]));
			}
			if (parenCheck(equation1) && parenCheck(equation2)) {
				if (equation1.indexOf(',') > 0) {
					return compareEquationArray(equation1.split(","),
							equation2.split(","));
				}
				if (equation1.indexOf('=') > 0) {

					if (compareAddition(
							equation1.substring(0, equation1.indexOf('=')),
							equation2.substring(0, equation2.indexOf('=')))) {
						return compareAddition(
								equation1.substring(equation1.indexOf('=') + 1),
								equation2.substring(equation2.indexOf('=') + 1));
					}
					if (compareAddition(
							equation1.substring(0, equation1.indexOf('=')),
							equation2.substring(equation2.indexOf('=') + 1))) {
						return compareAddition(
								equation1.substring(equation1.indexOf('=') + 1),
								equation2.substring(0, equation2.indexOf('=')));
					}
				}

				return compareAddition(equation1, equation2);
			}
		} catch (Exception e) {
		}
		return false;
	}
	
	private static boolean compareEquationArray(String[] equation1,
			String[] equation2) {
		if (equation1.length != equation2.length) {
			return false;
		}

		for (int i = 0; i < equation1.length; i++) {
			for (int j = 0; j < equation2.length; j++) {
				if (equation1[i] != null && equation2[j] != null
						&& compareEquations(equation1[i], equation2[j])) {
					equation1[i] = null;
					equation2[j] = null;
				}
			}
		}
		for (int i = 0; i < equation1.length; i++) {
			if (equation1[i] != null) {
				return false;
			}
		}
		return true;
	}

	private static String trimParen(String str) {
		if (str.charAt(0) != '('
				|| getFirstInstanceOfSameDepthChar(str, ')', 1) != str
						.length() - 1) {
			return str;
		}
		return trimParen(str.substring(1, str.length() - 1)); // (Unclosed
																// parenthesis
	}
	
	private static String[] groupByAddition(String eq) {


		// System.out.println("ADD:   "+eq);
		String[] add = new String[10];
		int i = 0;
		// Because isEmpty doesn't work on API 8
		while (eq.length() != 0) {

			if (getFirstInstanceOfSameDepthChar(eq, '+', 0) != -1) {
				add[i] = eq.substring(0, getFirstInstanceOfSameDepthChar(eq, '+', 0));
				eq = eq.substring(getFirstInstanceOfSameDepthChar(
						eq, '+', 0) + 1);
				// System.out.println(add[i]);
				i++;
			} else {
				add[i] = eq;
				// System.out.println(add[i]);
				eq = "";
			}
		}
		return add;
	}

	private static String[] groupByMultiplication(String eq) {
		// System.out.println("MULT:     "+eq);
		String[] mult = new String[10];
		int i = 0;
		// Because isEmpty doesn't work on API 8
		while (eq.length() != 0) {
			if (getFirstInstanceOfSameDepthChar(eq, '*', 0) != -1) {
				mult[i] = eq.substring(0, getFirstInstanceOfSameDepthChar(eq, '*', 0));
				eq = eq.substring(getFirstInstanceOfSameDepthChar(
						eq, '*', 0) + 1);
				// System.out.println(mult[i]);
				i++;
			} else {
				mult[i] = eq;
				eq = "";
				// System.out.println(mult[i]);
			}
		}

		return mult;
	}

	private static String[] groupByExponentiation(String eq) {
		// System.out.println("EXP:     "+eq);
		String[] exp = new String[10];
		int i = 0;

		while (eq.length() != 0) {
			if (getFirstInstanceOfSameDepthChar(eq, '^', 0) != -1) {
				exp[i] = eq.substring(0, getFirstInstanceOfSameDepthChar(eq, '^', 0));
				eq = eq.substring(getFirstInstanceOfSameDepthChar(
						eq, '^', 0) + 1);
				// System.out.println(exp[i]);
				i++;
			} else {
				exp[i] = eq;
				eq = "";
				// System.out.println(exp[i]);
			}
		}

		return exp;
	}

	private static boolean compareAddition(String eq, String ans) {
		boolean ret = true;
		if (eq.equals(ans)) {
			return true;
		}
		String[] eqSub = groupByAddition(eq);
		String[] ansSub = groupByAddition(ans);
//		System.out.println(eqSub[0]);
//		System.out.println(ansSub[0]);
		if (eqSub[1]==null&&ansSub[1]==null)
		{
			return compareMultiplcation(eq,ans);
		}

		for (int i = 0; i < eqSub.length; i++) {
			if (eqSub[i] != null) {
				if (getFirstInstanceOfSameDepthChar(eqSub[i], '*',
						0) > 0) {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& compareMultiplcation(eqSub[i], ansSub[j])) {
							// System.out.println(eqSub[i] + " = 0");
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				} else if (getFirstInstanceOfSameDepthChar(
						eqSub[i], '^', 0) > 0) {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& compareExponentiation(eqSub[i], ansSub[j])) {
							// System.out.println(eqSub[i] + " = 0");
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				} else {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& eqSub[i].charAt(0) == '(') {
							if (compareAddition(trimParen(eqSub[i]), trimParen(ansSub[j]))) {
								eqSub[i] = null;
								ansSub[j] = null;
							}
						} else if (eqSub[i] != null
								&& eqSub[i].equals(ansSub[j])) {
							// System.out.println(eqSub[i] + " = 0");
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				}

			}

		}
		for (String st1 : eqSub) {
			if (st1 != null) {
				ret = false;
			}
		}
		for (String st2 : ansSub) {
			if (st2 != null) {
				ret = false;
			}
		}
		return ret;
	}

	private static boolean compareExponentiation(String eq, String ans) {

		boolean ret = true;
		if (eq.equals(ans)) {
			return true;
		}
		String[] eqSub = groupByExponentiation(eq);
		String[] ansSub = groupByExponentiation(ans);
		if (eqSub[1]==null&&ansSub[1]==null)
		{
			return eqSub[0].equals(ansSub[0]);
		}
		for (int i = 0; i < eqSub.length; i++) {

			if (eqSub[i] != null) {

				if (getFirstInstanceOfSameDepthChar(eqSub[i], '^',
						0) > -1) {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& compareExponentiation(eqSub[i], ansSub[j])) {
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				} else {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& eqSub[i].charAt(0) == '(') {
							if (compareAddition(trimParen(eqSub[i]), trimParen(ansSub[j]))) {
								eqSub[i] = null;
								ansSub[j] = null;
							}
						}
						if (eqSub[i] != null && eqSub[i].equals(ansSub[j])) {
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				}
			}
		}
		for (String st1 : eqSub) {
			if (st1 != null) {
				ret = false;
			}
		}
		for (String st2 : ansSub) {
			if (st2 != null) {
				ret = false;
			}
		}
		return ret;
	}

	private static boolean compareMultiplcation(String eq, String ans) {

		boolean ret = true;
		if (eq.equals(ans)) {
			return true;
		}
		String[] eqSub = groupByMultiplication(eq);
		String[] ansSub = groupByMultiplication(ans);
		if (eqSub[1]==null&&ansSub[1]==null)
		{

			return compareExponentiation(eq,ans);
		}
		for (int i = 0; i < eqSub.length; i++) {

			if (eqSub[i] != null) {

				if (getFirstInstanceOfSameDepthChar(eqSub[i], '^',
						0) > -1) {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& compareExponentiation(eqSub[i], ansSub[j])) {
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				} else {
					for (int j = 0; j < ansSub.length; j++) {
						if (eqSub[i] != null && ansSub[j] != null
								&& eqSub[i].charAt(0) == '(') {
							if (compareAddition(trimParen(eqSub[i]), trimParen(ansSub[j]))) {
								eqSub[i] = null;
								ansSub[j] = null;
							}
						}
						if (eqSub[i] != null && eqSub[i].equals(ansSub[j])) {
							eqSub[i] = null;
							ansSub[j] = null;
						}
					}
				}
			}
		}
		for (String st1 : eqSub) {
			if (st1 != null) {
				ret = false;
			}
		}
		for (String st2 : ansSub) {
			if (st2 != null) {
				ret = false;
			}
		}
		return ret;
	}

	
	private static boolean parenCheck(String eq) {
		int count = 0;
		for (int i = 0; i < eq.length(); i++) {
			if (eq.charAt(i) == '(')
				count++;
			else if (eq.charAt(i) == ')')
				count--;
		}
		return count == 0;
	}

	private static String prepEquation(String eq) {
		String ret = "";

		eq = eq.replace(" ", "");
		if (!eq.contains(","))
		{
			eq = trimParen(eq);
		}
		eq = eq.replaceAll("([^(,])-", "$1+-");
		eq = eq.replace("-(", "-1*(");
		if (eq.charAt(0)=='+')
		{
			eq = eq.substring(1);
		}
		eq = eq.replace("/", "*1/");
		eq = eq.replace("=<", "<=");
		eq = eq.replace("=>", ">=");
		eq = eq.replaceAll("(\\w)\u221A", "$1*\u221A");
		eq = eq.replaceAll("\u221A(\\d+)", "\u221A\\($1\\)");
		eq = eq.replaceAll("\u221A(\\w)", "\u221A\\($1\\)");

		ret += eq.charAt(0);
		for (int i = 1; i < eq.length(); i++) {
			if (Character.isLetter(eq.charAt(i - 1))
					&& (Character.isLetter(eq.charAt(i))
							|| Character.isDigit(eq.charAt(i)) || eq.charAt(i) == '(')) {
				ret += '*';
			} else if (Character.isDigit(eq.charAt(i - 1))
					&& (Character.isLetter(eq.charAt(i)) || eq.charAt(i) == '(')) {
				ret += '*';
			} else if (eq.charAt(i - 1) == ')'
					&& (Character.isLetter(eq.charAt(i))
							|| Character.isDigit(eq.charAt(i)) || eq.charAt(i) == '(')) {
				ret += '*';
			}
			ret += eq.charAt(i);
		}
		return ret;
	}
	
	// Former StringHelper classes
	private static int getFirstInstanceOfSameDepthChar(String s, char c,
			int startIndex) {
		return getFirstInstanceOfSameDepthChar(new StringBuffer(s), c,
				startIndex);
	}

	private static int getFirstInstanceOfSameDepthChar(StringBuffer s, char c,
			int startIndex) {
		int depth = 0;
		for (int i = startIndex; i < s.length(); i++) {
			char cur = s.charAt(i);
			if (depth == 0 && cur == c) {
				return i;
			}
			if (cur == '(') {
				depth++;
			}
			if (cur == ')') {
				depth--;
			}
		}
		return -1;
	}

	private static String removeWhitespace(String str) {
		// Remove space, then tab, then newline, then carriage return.
		return str.replace(" ", "").replace("	", "").replace("\n", "")
				.replace("\r", "");
	}

	
}