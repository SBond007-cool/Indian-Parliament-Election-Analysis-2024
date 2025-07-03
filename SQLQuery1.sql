select * from dbo.statewise_results;
select * from dbo.partywise_results;
select * from dbo.constituencywise_results;
select * from dbo.state;
select * from dbo.constituencywise_details;
 
select distinct count(Parliament_Constituency) As Total_Seat
from dbo.constituencywise_results;

--What is the total number of seats available 
--for elections in each state

select 
s.state as State_Name,
count(cr.Parliament_constituency) as Parliament_Seats
from dbo.constituencywise_results cr
INNER JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN dbo.state s ON sr.State_ID = s.State_ID 
GROUP BY s.State ;



--Total Seats Won by NDA Allianz

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN [Won]
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    dbo.partywise_results;

   
    
    --Seats Won by NDA Allianz Parties
SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    dbo.partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC;


SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    dbo.partywise_results;




    SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    dbo.partywise_results
WHERE 
    party IN (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
    ORDER BY Seats_Won DESC;




    

