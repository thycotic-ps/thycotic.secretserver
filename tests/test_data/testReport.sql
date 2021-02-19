SELECT gdn.DisplayName AS [GroupName]
    ,CASE g.Active WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' END AS [IsGroupActive]
FROM tbGroup g WITH (NOLOCK)
INNER JOIN vGroupDisplayName gdn WITH (NOLOCK) ON g.GroupId = gdn.GroupId
LEFT JOIN tbUserGroup ug WITH (NOLOCK) ON g.GroupId = ug.GroupId
LEFT JOIN tbUser u WITH (NOLOCK) ON ug.UserId = u.UserId
    AND u.OrganizationId = #Organization
WHERE (u.[Enabled] = 1 OR u.UserId IS NULL) AND g.IsPersonal = 0
    AND g.OrganizationId = #Organization AND g.SystemGroup = 0
ORDER BY [GroupName] ASC ,2