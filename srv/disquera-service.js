const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { Musicians } = this.entities;
  this.on('getMusicianByID', async (req) => {
    const { musicianID } = req.data;
    try {
      const musician = await SELECT.from(Musicians).where({ ID: musicianID })

      if (!musician) {
          req.error(404, `${musicianID} no encontrado.`);
      }
      return musician;
    } catch (error) {
      throw new Error(error)
    }
});
this.on('InsertMassMusicians', async (req) => {
  const { musicians } = req.data;
  try {
    const musiciansInserted = await INSERT.into(Musicians).entries(musicians)
    return musiciansInserted;
  } catch (error) {
    throw new Error(error)
  }

});
this.on('DeleteMassMusicians', async (req) => {
  const { IDS } = req.data;

  for (let i = 0; i < IDS.length; i++) {
      try {
        const musicianID = IDS[i]
          await DELETE.from(Musicians).where({ ID: musicianID })

      } catch (error) {
        throw new Error(error)
      }
  }
  return `deleted: ${IDS.length}`
});
this.before("CREATE", "Sessions", async(req)=>{
  let { hours } = req.data;
  try {
    if(hours >= 6){
      req.data.hours = hours+2
      req.data.promotion = true
    }
  } catch (error) {
    throw new Error(error)
  }
})
this.after("UPDATE", "Sessions", async(req)=>{
  try {
    if(hours >= 6){
      req.data.hours = hours
    }
  } catch (error) {
    throw new Error(error)
  }
})

});