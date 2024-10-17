/**
 * 
 * @Before(event = { "UPDATE" }, entity = "demouser01Srv.Incidents")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = async function(request) {
    const { Incidents } = cds.entities;

    // Fetch the incident to be updated
    const incident = await SELECT.one.from(Incidents).where({ ID: request.data.ID });

    // Check if the incident exists and its status is closed (case insensitive)
    if (incident && incident.status && incident.status.toLowerCase() === 'closed') {
        request.reject(400, 'Cannot modify an incident with status closed.');
    }

    this.on('READ', 'Suppliers', async req => {
        const bupa =  await cds.connect.to('BusinessPartnerA2X');
        return bupa.run(req.query);
    });

    this.on('READ', 'PurchaseOrders', async req => {
        const bupa =  await cds.connect.to('PurchaseOrder');
        return bupa.run(req.query);
    });

}