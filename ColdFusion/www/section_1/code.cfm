<h1>Setting Variables</h1>

<cfset thisIs = "fun">
<cfdump  var="#thisIs#"><br />

<!--- ## are used to evaluate stuff --->
<cfdump var = "1 + 2" /><br />
<cfdump var = "#1 + 2#" /><br />
<cfdump var = "1 + 2 IS #1 + 2#" /><br />

<hr />
<!--- Values on the right of "=" are evaluated by default --->
<cfset DateToday = now() />
<cfdump var = "#DateToday#" /><br />

<hr />
<!--- Evaluation in strings --->
<cfset DateToday = "Today is: #now()#" />
<cfdump var = "#DateToday#" /><br />

<hr />
<!--- String concatenation --->
<cfset DateToday = "Today is: " & now() />
<cfdump var = "#DateToday#" /><br />

<cfset DateToday = "Today is: " />
<cfset DateToday = DateToday & now() />
<cfdump var = "#DateToday#" /><br />

<hr />
<cfset DateToday = "Today is: #now()#" />
<cfoutput>#DateToday#</cfoutput>




<h1>Strings / Numbers</h1>

<cfset aString = "hi" />
<cfset aNumber = 42 />
<cfset aStringAndANumber = aString & aNumber />

aString: <cfoutput>#aString#</cfoutput>
aNumber: <cfoutput>#aNumber#</cfoutput>
aStringAndANumber: <cfoutput>#aStringAndANumber#</cfoutput>

<!--- cfsavecontent allows to write big block of string to a variable --->
<cfsavecontent variable="EmailContent">
    Hi 
    
    We want to send you a hoverboard.
    Let us know if you will accept this free offer.
    
    -Us
</cfsavecontent>

<cfoutput>#EmailContent#</cfoutput>

<hr/>
<cfset DateToday = now() />
<cfset NewYearDay = "1/1/2013" />
<cfdump var = "#NewYearDay#" />
<cfoutput>#NewYearDay#</cfoutput><br/>

<cfset DaysSinceTurnOfCentury = DateDiff("d", "1/1/2000", now() ) />
<cfoutput>#DaysSinceTurnOfCentury#</cfoutput><br/>

<cfset FortyTwoDaysFromNow = DateAdd("d", now(), 42 ) />
<cfoutput>#FortyTwoDaysFromNow#</cfoutput>

<hr/>
<cfset ThingsILike = ["Warm Sandy Beaches", "Tropical Drinks", 42] />
<cfdump var = "#ThingsILike#" />

<!--- Another way to create array --->
<cfset ThingsILike = arrayNew(1) />

<!--- Arrays start at one --->
<!--- Adding items to an array --->
<cfset ThingsILike[1]  = "Warm Sandy Beaches" />

<!--- Appending items to an array --->
<cfset ArrayAppend( ThingsILike,  "Tropical Drinks") />
<cfset ArrayAppend( ThingsILike,  42) />
<cfdump var="#ThingsILike#" />

<!--- Evaluation in an array works as well --->
<cfset ImportantDates = ["12/26/1975", now() ] />
<cfdump var = "#ImportantDates#" />

<!--- Looping through array --->
<cfset ThingsILike = ["Warm Sandy Beaches", "Tropical Drinks", 42] />
<cfloop array="#ThingsILike#" index="thing">
    <cfoutput>#thing#</cfoutput>
</cfloop>

<hr/>
<!--- Creating a structure (a collection of data, stored by a key, or name) --->
<cfset FruitBasket = structNew() />
<cfset FruitBasket = {} />

<!--- Adding items via bracket notation --->
<cfset FruitBasket = {} />
<cfset FruitBasket["Apple"] = "Like" />
<cfset FruitBasket["Banana"] = "Like" />
<cfset FruitBasket["Cherry"] = "Dislike" />
<cfdump var = "#FruitBasket#" />

<!--- Adding items via dot notation --->
<cfset FruitBasket = {} />
<cfset FruitBasket.Apple = "Like" />
<cfset FruitBasket.Banana = "Like" />
<cfset FruitBasket.Cherry = "Dislike" />
<cfdump var = "#FruitBasket#" />

<!--- Struct Creation and Population in One Statement --->
<cfset fruitBasket = {
    "Apple" = "Like",
    "Banana" = "Like",
    "Cherry" = "Dislike"
} />
<cfdump var = "#FruitBasket#" />

<!--- Looping through Struct --->
<cfloop collection="#FruitBasket#" item="fruit">
    <cfoutput>I #FruitBasket[fruit]# #fruit#</cfoutput><br />
</cfloop>

<hr/>
<!--- <cfquery name="FruitQuery" datasource="fruit">
    SELECT Name, Price
    FROM FruitStore
    WHERE Price < 7
</cfquery>

<cfloop query="FruitQuery">
    #FruitQuery.Name# costs #FruitQuery.Price# <br />
</cfloop> --->