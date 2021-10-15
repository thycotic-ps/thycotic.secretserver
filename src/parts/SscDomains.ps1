"US,secretservercloud.com",
"AU,secretservercloud.com.au",
"CA,secretservercloud.ca",
"EU,secretservercloud.eu",
"SG,secretservercloud.com.sg" | ConvertFrom-Csv -Header 'Region', 'Domain'