select * from dbo.statewise_results;
select * from dbo.partywise_results;
select * from dbo.constituencywise_results;
select * from dbo.state;
select * from dbo.constituencywise_details;


alter table dbo.partywise_results
    Add Party_Alliance varchar(50);


--I.N.D.I.A Allianz
UPDATE dbo.partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);


--NDA Allianz
UPDATE dbo.partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
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
);
--OTHER
UPDATE dbo.partywise_results
SET party_alliance = 'NON_Allianz'
WHERE party_alliance IS NULL;


select Party_Alliance , Sum(Won) As Number_of_Seats
from dbo.partywise_results 
group by Party_Alliance ;


SELECT cr.Winning_Candidate,
p.Party,
p.party_alliance, 
cr.Total_Votes,
cr.Margin, 
cr.Constituency_Name,
s.State
FROM dbo.constituencywise_results cr
JOIN dbo.partywise_results p ON cr.Party_ID = p.Party_ID
JOIN dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN dbo.state s ON sr.State_ID = s.State_ID
WHERE s.State = 'Maharashtra' AND cr.Constituency_Name = 'NAGPUR';



SELECT 
    cd.Candidate,
    cd.Party,
    cd.EVMVotes,
    cd.PostalVotes,
    cd.TotalVotes
FROM 
    dbo.constituencywise_details cd
JOIN 
    dbo.constituencywise_results cr ON cd.ConstituencyID = cr.Constituency_ID
WHERE 
    cr.Constituency_Name = 'MATHURA'
ORDER BY cd.TotalVotes DESC;


SELECT 
    p.Party,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    dbo.constituencywise_results cr
JOIN 
    dbo.partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN dbo.state s ON sr.State_ID = s.State_ID
WHERE 
    s.state = 'Andhra Pradesh'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;


--Which candidate received the highest number
--of EVM votes in each constituency (Top 10)?


with SN as (
select s.State,
cr1.Constituency_ID
FROM 
    dbo.constituencywise_results cr1
JOIN 
    dbo.statewise_results sr ON 
        cr1.Parliament_Constituency = sr.Parliament_Constituency
JOIN dbo.state s ON sr.State_ID = s.State_ID
)
select top 10 
SN.State,
cr.Constituency_Name,
cd.Party,
cd.Candidate,
cd.EVMVotes,

cr.Total_Votes
from dbo.constituencywise_details cd 
inner join dbo.constituencywise_results cr 
ON cd.ConstituencyID = cr.Constituency_ID
inner join SN on cd.ConstituencyID = SN.Constituency_ID
order by cd.EVMVotes DESC;

--Which candidate won and which candidate was the runner-up in
--each constituency of State for the 2024 elections?

WITH RankedCandidates AS (
    SELECT 
        cd.ConstituencyID,
        cd.Candidate,
        cd.Party,
        cd.EVMVotes,
        cd.PostalVotes,
        cd.EVMVotes + cd.PostalVotes AS Total_Votes,
            ROW_NUMBER() 
                OVER (PARTITION BY cd.ConstituencyID 
                ORDER BY cd.EVMVotes + cd.PostalVotes
                DESC) AS VoteRank
    FROM 
        dbo.constituencywise_details cd
    JOIN 
        dbo.constituencywise_results cr 
                    ON cd.ConstituencyID = cr.Constituency_ID
    JOIN 
        dbo.statewise_results sr 
                    ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        dbo.state s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Maharashtra'
)

SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    dbo.constituencywise_results cr ON rc.ConstituencyID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;

    
--For the state of Maharashtra, what are the total number of seats, 
--total number of candidates, total number of parties,
--total votes (including EVM and postal), and 
--the breakdown of EVM and postal votes?


    SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVMVotes + cd.PostalVotes) AS Total_Votes,
    SUM(cd.EVMVotes) AS Total_EVM_Votes,
    SUM(cd.PostalVotes) AS Total_Postal_Votes

FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.Constituency_ID = cd.ConstituencyID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    state s ON sr.State_ID = s.State_ID
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Tamil Nadu';
