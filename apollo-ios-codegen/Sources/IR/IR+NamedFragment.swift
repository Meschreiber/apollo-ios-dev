import GraphQLCompiler
import OrderedCollections

public class NamedFragment: Hashable, CustomDebugStringConvertible {
  public let definition: CompilationResult.FragmentDefinition
  public let rootField: EntityField

  /// All of the fragments that are referenced by this fragment's selection set.
  public let referencedFragments: OrderedSet<NamedFragment>

  /// All of the Entities that exist in the fragment's selection set,
  /// keyed by their relative location (ie. path) within the fragment.
  ///
  /// - Note: The FieldPath for an entity within a fragment will begin with a path component
  /// with the fragment's name and type.
  let entities: [Entity.Location: Entity]

  public var name: String { definition.name }
  public var type: GraphQLCompositeType { definition.type }

  init(
    definition: CompilationResult.FragmentDefinition,
    rootField: EntityField,
    referencedFragments: OrderedSet<NamedFragment>,
    entities: [Entity.Location: Entity]
  ) {
    self.definition = definition
    self.rootField = rootField
    self.referencedFragments = referencedFragments
    self.entities = entities
  }

  public static func == (lhs: NamedFragment, rhs: NamedFragment) -> Bool {
    lhs.definition == rhs.definition &&
    lhs.rootField === rhs.rootField
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(definition)
    hasher.combine(ObjectIdentifier(rootField))
  }

  public var debugDescription: String {
    definition.debugDescription
  }
}
