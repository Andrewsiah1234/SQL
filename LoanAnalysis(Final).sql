###LoanAnalysis
	"In order to monitor and assess our bank's lending activities and performance,
	we need to create a comprehensive Bank Loan Report. 
	This report aims to provide insights into key loan-related metrics and their changes over time.
	The report will help us make data-driven decisions, track our loan portfolio's health, and identify trends that can inform our lending strategies."

##KPI Requirements

1.Total Loan Applications:
Select COUNT(Distinct id) AS Total_Loan_Applications from loan

MTD Loan Applications :
Select COUNT(Distinct id) AS MTD_Loan_Applications from loan
where  MONTH(issue_date) = 12

PMTD Loan Applications :
Select COUNT(Distinct id) AS PMTD_Loan_Applications from loan
where  MONTH(issue_date) = 11

2.Total Funded Amount
Select SUM(loan_amount) AS Total_Funded_Amount from loan

MTD Funded Amount : 
Select SUM(loan_amount) AS MTD_Funded_Amount from loan
where  MONTH(issue_date) = 12

PMTD Funded Amount :
Select SUM(loan_amount) AS PMTD_Funded_Amount from loan
where  MONTH(issue_date) = 11

3.Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM loan
 
MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Amount_Collected FROM loan
WHERE MONTH(issue_date) = 12
 
PMTD Total Amount Received
SELECT SUM(total_payment) AS PMTD_Amount_Collected FROM loan
WHERE MONTH(issue_date) = 11

4.Average Interest Rate 
Select ROUND(AVG(int_rate),4)*100 AS AVG_Int_rate from loan

MTD Average Interest Rate 
Select ROUND(AVG(int_rate),4)*100 AS MTD_AVG_Int_rate from loan
WHERE Month(issue_date) = 12

PMTD Average Interest Rate 
Select ROUND(AVG(int_rate),4)*100 AS PMTD_AVG_Int_rate from loan
WHERE Month(issue_date) = 11

5.Average Debt-to-Income Ratio 
SELECT ROUND(AVG(dti),4)*100 AS AVG_Debt_to_Income from loan

MTD Average Debt-to Income Ratio
SELECT ROUND(AVG(dti),4)*100 AS MTD_AVG_Debt_to_Income from loan
WHERE Month(issue_date)=12

PMTD Average Debt-to Income Ratio
SELECT ROUND(AVG(dti),4)*100 AS PMTD_AVG_Debt_to_Income from loan
WHERE Month(issue_date)=11

#Good Loan KPI

1.Good Loan Application Percentage 
SELECT
(COUNT(CASE WHEN loan_status = 'Fully Paid' or loan_status = 'Current' THEN id END)*100.0)
/
COUNT(id) AS Good_Loan_Application_Percentage
FROM loan

2.Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications from loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

3.Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount from loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

4.Good Loan Total Received Amount 
SELECT SUM(total_payment) AS Good_Loan_Total_Received_Amount from loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

#Bad Loan KPI

1.Bad Loan Application Percentage 
SELECT
(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)
/
COUNT(id) AS Bad_Loan_Application_Percentage
FROM loan

2.Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications from loan
WHERE loan_status = 'Charged Off'

3.Good Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount from loan
WHERE loan_status = 'Charged Off'

4.Good Loan Total Received Amount 
SELECT SUM(total_payment) AS Bad_Loan_Total_Received_Amount from loan
WHERE loan_status = 'Charged Off'

##Dashboard Overview

1.Monthly Trends by Issue Date

Select 
	MONTH(issue_date)AS Month_Number,
	DATENAME(MONTH,issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM loan 
GROUP BY DATENAME(MONTH,issue_date),MONTH(issue_date)
ORDER BY MONTH(issue_date)

2.Regional Analysis by State

Select 
	address_state AS State,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM loan 
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC

3.Loan Term Analysis 

Select 
	term ,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM loan 
GROUP BY term

4.Employee Length Analysis 

Select 
	emp_length ,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM loan 
GROUP BY emp_length
ORDER BY emp_length

5.Loan Purpose Breakdown
Select 
	purpose ,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM loan 
GROUP BY purpose
ORDER BY Total_Funded_Amount DESC

6.Home Ownership Analysis 

Select 
	home_ownership ,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM loan 
GROUP BY home_ownership
ORDER BY Total_Funded_Amount DESC
