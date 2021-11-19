select * from dbo.SocialMediaCampaign$

-- Business marketing campaign experiments conducted through Social Media

-- Three total Campaigns 
-- 464 ADs, 54 ADs and 625 ADs issued for each campaign

select campaign_id, count(campaign_id) as CountOfPublicityAds 
from dbo.SocialMediaCampaign$
group by campaign_id

-- Customer conversions accounted by Gender 
-- Female = 48 %  Male = 51 % 

select gender, count(total_conversion) * 100 / (select count(*) from dbo.SocialMediaCampaign$)
	as ConversionPercent
from dbo.SocialMediaCampaign$ 
group by gender

create view ConversionsByCampaign AS 
Select campaign_id, gender, total_conversion from dbo.SocialMediaCampaign$
group by gender, campaign_id, Total_Conversion;

 -- Campaign ID 1178 received Highest traffic at 3 Million impressions  
 -- Capital required $640.00 for campaign 

 select top 3 spent, campaign_id, Impressions
 from dbo.SocialMediaCampaign$
 group by campaign_id, Impressions, Spent
 order by Spent desc

 -- Campaign ID 1178 received the highest conversion count of 60 customer accounts
 -- with a Number of 625 ads required to reach such conversions 

 select max(total_conversion) HighestConversionRate,
		count(ad_id) NumberofAdsRequired, campaign_id
 from dbo.SocialMediaCampaign$
 group by campaign_id

 -- Females tend to engage with clicking through ADs double the amount of times as Males 
 -- Overall interest is almost equally split between Males = 32 and Females = 34

 Create proc AvgCustomerInteractionByGender as 
 select avg(clicks) as AvgClicks, AVG(interest) AvgInterest, gender
 from dbo.SocialMediaCampaign$
 group by gender;
 execute AvgCustomerInteractionByGender

 --Campaign ID: 916 with Highest Ad Expense for traffic generated 

 select impressions, campaign_id, sum(spent) as AdExpense, 
	FIRST_VALUE(campaign_id) over (partition by campaign_id order by spent desc) HighestAdExpense
 from dbo.SocialMediaCampaign$
group by campaign_id, Spent, Impressions

-- Required Ads 625 for Campaign ID 1178, to convert 54 Percent of traffic
-- Campaign ID 936 , 40 Percent Conversion rate
-- Campaign ID 916 , 4 Percent Conversion rate 
select count(total_conversion) * 100 / (select count(*) from dbo.SocialMediaCampaign$) as ConversionPercent, campaign_Id 
from dbo.SocialMediaCampaign$
group by campaign_id
order by ConversionPercent desc

-- Second Highest traffic Campaign 936, Ads issued 464 to generate 40 % customer conversion from traffic 
select sum(Impressions) Impressions, count(ad_id) countofads, campaign_id 
from dbo.SocialMediaCampaign$
group by campaign_id
order by countofads desc 
offset 1 row fetch next 1 row only 

-- Over $450.00 spending required to convert atleast 40 percent of traffic
select campaign_id, sum(Spent) Ad_Expense_Required, 
		sum(Total_Conversion) * 100 / (select count(*) from SocialMediaCampaign$) ConversionPercent
from dbo.SocialMediaCampaign$
group by campaign_id, spent
order by ConversionPercent desc

--Campaign ID 1178 with customer interest of +100 customer accounts 
select COUNT(ad_id) as NumberAds, campaign_id, interest from dbo.SocialMediaCampaign$
 where interest > 100
 group by campaign_id, interest
