﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Core.Objects;
using System.Linq;

public partial class SeeYourTravelEntities : DbContext
{
    public SeeYourTravelEntities()
        : base("name=SeeYourTravelEntities")
    {
    }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
        throw new UnintentionalCodeFirstException();
    }

    public virtual DbSet<Role> Roles { get; set; }
    public virtual DbSet<User> Users { get; set; }
    public virtual DbSet<UserLocation> UserLocations { get; set; }
    public virtual DbSet<UserRole> UserRoles { get; set; }
    public virtual DbSet<UserLogin> UserLogins { get; set; }
    public virtual DbSet<Image> Images { get; set; }
    public virtual DbSet<ImageUser> ImageUsers { get; set; }
    public virtual DbSet<Place> Places { get; set; }
    public virtual DbSet<PlaceImage> PlaceImages { get; set; }
    public virtual DbSet<PlaceType> PlaceTypes { get; set; }
    public virtual DbSet<PlaceTypePlace> PlaceTypePlaces { get; set; }
    public virtual DbSet<PlaceUser> PlaceUsers { get; set; }
    public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
    public virtual DbSet<Track> Tracks { get; set; }
    public virtual DbSet<TrackUser> TrackUsers { get; set; }

    public virtual ObjectResult<GetFriendsLocations_Result> GetFriendsLocations(Nullable<System.Guid> userID)
    {
        var userIDParameter = userID.HasValue ?
            new ObjectParameter("UserID", userID) :
            new ObjectParameter("UserID", typeof(System.Guid));

        return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetFriendsLocations_Result>("GetFriendsLocations", userIDParameter);
    }

    [DbFunction("SeeYourTravelEntities", "GetUserandPublicTracks")]
    public virtual IQueryable<GetUserandPublicTracks_Result> GetUserandPublicTracks(Nullable<System.Guid> userID)
    {
        var userIDParameter = userID.HasValue ?
            new ObjectParameter("UserID", userID) :
            new ObjectParameter("UserID", typeof(System.Guid));

        return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<GetUserandPublicTracks_Result>("[SeeYourTravelEntities].[GetUserandPublicTracks](@UserID)", userIDParameter);
    }

    [DbFunction("SeeYourTravelEntities", "GetTrackForUserByIdOrName")]
    public virtual IQueryable<GetTrackForUserByIdOrName_Result> GetTrackForUserByIdOrName(Nullable<System.Guid> userID, Nullable<System.Guid> trackId, string name)
    {
        var userIDParameter = userID.HasValue ?
            new ObjectParameter("UserID", userID) :
            new ObjectParameter("UserID", typeof(System.Guid));

        var trackIdParameter = trackId.HasValue ?
            new ObjectParameter("TrackId", trackId) :
            new ObjectParameter("TrackId", typeof(System.Guid));

        var nameParameter = name != null ?
            new ObjectParameter("Name", name) :
            new ObjectParameter("Name", typeof(string));

        return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<GetTrackForUserByIdOrName_Result>("[SeeYourTravelEntities].[GetTrackForUserByIdOrName](@UserID, @TrackId, @Name)", userIDParameter, trackIdParameter, nameParameter);
    }
}
