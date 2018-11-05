# Scenarios with Components

## This repository provides assets to how components/apex/etc were utilized to tackle various integration scenarios. Scenarios are as follows:

(1) Calling out to external apps (i.e., for quoting app) - this will be a REST callout that hits a web service, gets a response and processes it (It will be a variation of processing for process-driven actions as well as a callout for UI rendering, to illustrate different techniques for UI-driven use cases and Process-driven use cases). Scenario 1A is Process-Driven, Scenario 1B is UI-Driven.

(2) Showing a callout - Claim header in Salesforce, but Claim Details aren't stored (pulled in via REST callout and front-ended with a Component).

(3) Calling a web service, that, based on a VIN number gets you a rate for your quote. It will be Process Builder firing Apex to send a web service and get a result, as well as UI alternative if want to render a rate and process it. Scenario 1A is Process-Driven, Scenario 1B is UI-Driven.
