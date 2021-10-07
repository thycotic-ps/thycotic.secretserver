"US,secretservercloud.com",
"AU,secretservercloud.com.au",
"CA,secretservercloud.ca",
"EU,secretservercloud.eu",
"SG,secretservecloud.com.sg" | ConvertFrom-Csv -Header 'Region', 'Domain'