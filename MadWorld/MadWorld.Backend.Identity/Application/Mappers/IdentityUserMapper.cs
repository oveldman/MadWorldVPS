using MadWorld.Backend.Identity.Contracts.UserManagers;
using MadWorld.Backend.Identity.Domain.Users;

namespace MadWorld.Backend.Identity.Application.Mappers;

public static class IdentityUserMapper
{
    public static List<UserContract> ToDto(this List<IdentityUserExtended> users)
    {
        return users
            .Select(ToUserContract)
            .ToList();
    }
    
    public static GetUserResponse ToDto(this IdentityUserExtended user, IEnumerable<string> roles)
    {
        return new GetUserResponse()
        {
            Id = user.Id,
            Email = user.Email!,
            Roles = roles.ToList()
        };
    }

    private static UserContract ToUserContract(IdentityUserExtended user)
    {
        return new UserContract
        {
            Id = user.Id,
            Email = user.Email!
        };
    }
}