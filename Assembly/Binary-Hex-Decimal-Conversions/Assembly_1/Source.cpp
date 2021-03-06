#include <iostream>
#include <string>
#include <vector>

int bin_dec(std::string ln){
	int num = 0;
	int counter = ln.length();
	for (size_t i = 0; i < ln.length(); i++)
	{
		if (ln[counter - 1] == '1')
		{
			num += std::pow(2, i);
		}
		counter--;
	}
	return num;
}
//Question 8
int main(){
	std::string line;
	std::cout << "Enter a 16-bit binary number to be converted to a decimal: ";
	std::cin >> line;
	int num = bin_dec(line);
	std::cout << "Your Number in decimal form: " << num << std::endl;

	return 0;
} 

//Question 9
int main1(){
	int num;
	std::cout << "Enter integer to be converted to hexadecimal: ";
	std::cin >> num;
	std::vector<int> arr;
	std::cout << num << " in hexadecimal is: ";
	while (num > 0){
		int rem = num % 16;
		arr.push_back(rem);
		num /= 16;
	}
	for (size_t i = arr.size(); i > 0; i--)
	{
		switch (arr[i - 1]){
		case 10:
			std::cout << 'A';
			break;
		case 11:
			std::cout << 'B';
			break;
		case 12:
			std::cout << 'C';
			break;
		case 13:
			std::cout << 'D';
			break;
		case 14:
			std::cout << 'E';
			break;
		case 15:
			std::cout << 'F';
			break;
		default:
			std::cout << arr[i - 1];
			break;
		}
	}
	std::cout << std::endl;
	return 0;
}

//Question 10
int main2(){
	std::vector<char> arr;

	std::string num1;
	std::cout << "Enter Hexadecimal number 1: ";
	std::cin >> num1;
		
	std::string num2;
	std::cout << "Enter Hexadecimal number 2: ";
	std::cin >> num2;
	for (size_t i = 0; i < num1.length(); i++)
	{
		num1[i] = toupper(num1[i]);
	}
	for (size_t i = 0; i < num2.length(); i++)
	{
		num2[i] = toupper(num2[i]);
	}
	
	int max{ 0 };
	int min{ 0 };
	std::string bigger;
	if (num1.length() > num2.length()){
		max = num1.length();
		min = num2.length();
		bigger = num1;
	}
	else{
		max = num2.length();
		min = num1.length();
		bigger = num2;
	}
	int bigC = bigger.length();

	


	int rem{ 0 };
	int div{ 0 };
	int num1_count = num1.length(), 
		num2_count = num2.length();
	for (size_t i = 0; i < max; i++)
	{
		
		int temp1{ 0 }, temp2{ 0 };
		if (i < min)
		{
			switch (num1[num1_count - 1]){
			case 'A':
				temp1 = 10;
				break;
			case 'B':
				temp1 = 11;
				break;
			case 'C':
				temp1 = 12;
				break;
			case 'D':
				temp1 = 13;
				break;
			case 'E':
				temp1 = 14;
				break;
			case 'F':
				temp1 = 15;
				break;
			default:
				int c = (num1[num1_count - 1] - '0');
				temp1 = c;
				break;
			}
			switch (num2[num2_count - 1]){
			case 'A':
				temp2 = 10;
				break;
			case 'B':
				temp2 = 11;
				break;
			case 'C':
				temp2 = 12;
				break;
			case 'D':
				temp2 = 13;
				break;
			case 'E':
				temp2 = 14;
				break;
			case 'F':
				temp2 = 15;
				break;
			default:
				int c = (num2[num2_count - 1] - '0');
				temp2 = c;
				break;
			}
			rem = (temp1 + temp2 + div) % 16;
			div = (temp1 + temp2 + div) / 16;
			switch (rem){
			case 10:
				arr.push_back('A');
				break;
			case 11:
				arr.push_back('B');
				break;
			case 12:
				arr.push_back('C');
				break;
			case 13:
				arr.push_back('D');
				break;
			case 14:
				arr.push_back('E');
				break;
			case 15:
				arr.push_back('F');
				break;
			default:
				arr.push_back(rem + '0');
				break;
			}
			num2_count--;
			num1_count--;
			if (i == (max - 1) && div != 0)
				max++;
		}
		else{
			if (div > 0 && bigC == 0)
			{
				arr.push_back(div + '0');
			}
			else if (div > 0)
			{
				switch (bigger[bigC - 1]){
				case 'A':
					temp2 = 10;
					break;
				case 'B':
					temp2 = 11;
					break;
				case 'C':
					temp2 = 12;
					break;
				case 'D':
					temp2 = 13;
					break;
				case 'E':
					temp2 = 14;
					break;
				case 'F':
					temp2 = 15;
					break;
				default:
					int c = (num2[num2_count - 1] - '0');
					temp2 = c;
					break;
				}
				rem = (temp2 + div) % 16;
				div = (temp2 + div) / 16;
				switch (rem){
				case 10:
					arr.push_back('A');
					break;
				case 11:
					arr.push_back('B');
					break;
				case 12:
					arr.push_back('C');
					break;
				case 13:
					arr.push_back('D');
					break;
				case 14:
					arr.push_back('E');
					break;
				case 15:
					arr.push_back('F');
					break;
				default:
					arr.push_back(rem + '0');
					break;
				}
				if (div > 0){
					max++;
				}
			}
			else{
				arr.push_back(bigger[bigC - 1]);

			}
		}
		bigC--;
	}
	for (size_t i = arr.size(); i > 0; i--)
	{
		std::cout << arr[i - 1];
	}


	return 0;
}

std::string add(std::string &str1, std::string &str2){
	std::vector<char> arr;
	int str1_count = str1.length();
	int str2_count = str2.length();
	int rem{ 0 };
	int div{ 0 };
	int temp1{ 0 }, temp2{ 0 };
	for (size_t i = 0; i < str1.length(); i++)
	{
		switch (str1[str1_count - 1]){
		case '1':
			temp1 = 1;
			break;
		case '0':
			temp1 = 0;
			break;
		}
		switch (str2[str2_count - 1]){
		case '1':
			temp2 = 1;
			break;
		case '0':
			temp2 = 0;
			break;
		}
		rem = (temp1 + temp2 + div) % 2;
		div = (temp1 + temp2 + div) / 2;
		arr.push_back(rem + '0');
		str1_count--;
		str2_count--;
	}
	std::string added = "";
	for (size_t i = arr.size(); i > 0; i--)
	{
		added += arr[i - 1];
	}
	
	return added;
}
std::string twosComp(std::string &str){
	std::string temp = "";
	for (size_t i = 0; i < str.length(); i++)
	{
		switch (str[i])
		{
		case '1':
			temp += '0';
			break;
		case '0':
			temp += '1';
			break;
		}
	}
	std::string twos{ "" };
	for (size_t i = 0; i < str.length() - 1; i++)
	{
		twos += "0";
	}
	twos += "1";
	twos = add(temp, twos);
	return twos;
}
//Question 11
int main3(){
	

	std::string num1;
	std::cout << "Enter binary number 1: ";
	std::cin >> num1;

	std::string num2;
	std::cout << "Enter bianry number 2: ";
	std::cin >> num2;

	std::string smaller;
	std::string bigger;
	int max{ 0 };
	int min{ 0 };
	std::string temp{ "" };
	if (num1.length() > num2.length()){
		max = num1.length();
		min = num2.length();
		smaller = num2;
		bigger = num1;
		for (size_t i = 0; i < (max - min); i++)
		{
			temp += "0";
		}
		if ((max - min) != 0)
		{
			smaller = temp + smaller;
		}
	}
	else{
		max = num2.length();
		min = num1.length();
		smaller = num1;
		bigger = num2;
		for (size_t i = 0; i < (max - min); i++)
		{
			temp += "0";
		}
		if ((max - min) != 0)
		{
			smaller = temp + smaller;
		}
		std::swap(smaller, bigger);
	}
	
	
	std::string twos_str = twosComp(smaller);
	std::string answer = add(bigger, twos_str);
	
	std::cout << answer << std::endl;
	return 0;
}